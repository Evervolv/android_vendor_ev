/*
 * Copyright (C) 2008 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <unistd.h>
#include <sys/capability.h>
#include <sys/prctl.h>

#include <cutils/properties.h>

#include "private/android_filesystem_config.h"

#define LOG_TAG "dumplogcat"
#include <cutils/log.h>

#include "dumplogcat.h"

#define PSTORE_LAST_KMSG "/sys/fs/pstore/console-ramoops"
#define ALT_PSTORE_LAST_KMSG "/sys/fs/pstore/console-ramoops-0"

/* Copied policy from system/core/logd/LogBuffer.cpp */

#define LOG_BUFFER_SIZE (256 * 1024)
#define LOG_BUFFER_MIN_SIZE (64 * 1024UL)
#define LOG_BUFFER_MAX_SIZE (256 * 1024 * 1024UL)

static bool valid_size(unsigned long value) {
    if ((value < LOG_BUFFER_MIN_SIZE) || (LOG_BUFFER_MAX_SIZE < value)) {
        return false;
    }

    long pages = sysconf(_SC_PHYS_PAGES);
    if (pages < 1) {
        return true;
    }

    long pagesize = sysconf(_SC_PAGESIZE);
    if (pagesize <= 1) {
        pagesize = PAGE_SIZE;
    }

    // maximum memory impact a somewhat arbitrary ~3%
    pages = (pages + 31) / 32;
    unsigned long maximum = pages * pagesize;

    if ((maximum < LOG_BUFFER_MIN_SIZE) || (LOG_BUFFER_MAX_SIZE < maximum)) {
        return true;
    }

    return value <= maximum;
}

static unsigned long property_get_size(const char *key) {
    unsigned long value;
    char *cp, property[PROPERTY_VALUE_MAX];

    property_get(key, property, "");
    value = strtoul(property, &cp, 10);

    switch(*cp) {
    case 'm':
    case 'M':
        value *= 1024;
    /* FALLTHRU */
    case 'k':
    case 'K':
        value *= 1024;
    /* FALLTHRU */
    case '\0':
        break;

    default:
        value = 0;
    }

    if (!valid_size(value)) {
        value = 0;
    }

    return value;
}

unsigned long worst_write_perf = 20000; /* in KB/s */

/* timeout in ms */
static unsigned long logcat_timeout(const char *name) {
    static const char global_tuneable[] = "persist.logd.size"; // Settings App
    static const char global_default[] = "ro.logd.size";       // BoardConfig.mk
    char key[PROP_NAME_MAX];
    unsigned long property_size, default_size;

    default_size = property_get_size(global_tuneable);
    if (!default_size) {
        default_size = property_get_size(global_default);
    }

    snprintf(key, sizeof(key), "%s.%s", global_tuneable, name);
    property_size = property_get_size(key);

    if (!property_size) {
        snprintf(key, sizeof(key), "%s.%s", global_default, name);
        property_size = property_get_size(key);
    }

    if (!property_size) {
        property_size = default_size;
    }

    if (!property_size) {
        property_size = LOG_BUFFER_SIZE;
    }

    /* Engineering margin is ten-fold our guess */
    return 10 * (property_size + worst_write_perf) / worst_write_perf;
}

/* End copy from system/core/logd/LogBuffer.cpp */

static void usage() {
    fprintf(stderr, "usage: dumplogcat -mrdk [-o file [-D] [-B]] [-s] [-q]\n"
            "  -m: main buffer\n"
            "  -r: radio buffer\n"
            "  -d: dmesg\n"
            "  -k: last_kmsg\n"
            "  -o: write to file (instead of stdout)\n"
            "  -D: append date to filename (requires -o)\n"
            "  -s: write output to control socket (for init)\n"
            "  -q: disable vibrate\n"
            "  -B: send broadcast when finished (requires -o)\n"
        );
}

static void vibrate(FILE* vibrator, int ms) {
    fprintf(vibrator, "%d\n", ms);
    fflush(vibrator);
}

int main(int argc, char *argv[]) {
    unsigned long timeout;
    int logcat = 0;
    int radio = 0;
    int dmesg = 0;
    int last_kmsg = 0;
    int do_add_date = 0;
    int do_vibrate = 1;
    char* use_outfile = 0;
    int use_socket = 0;
    int do_broadcast = 0;

    signal(SIGPIPE, SIG_IGN);

    /* set as high priority, and protect from OOM killer */
    setpriority(PRIO_PROCESS, 0, -20);
    FILE *oom_adj = fopen("/proc/self/oom_adj", "we");
    if (oom_adj) {
        fputs("-17", oom_adj);
        fclose(oom_adj);
    }

    int c;
    while ((c = getopt(argc, argv, "mrdkDho:svqB")) != -1) {
        switch (c) {
            case 'm': logcat = 1;              break;
            case 'r': radio = 1;             break;
            case 'd': dmesg = 1;             break;
            case 'k': last_kmsg = 1;         break;
            case 'D': do_add_date = 1;       break;
            case 'o': use_outfile = optarg;  break;
            case 's': use_socket = 1;        break;
            case 'v': break;  // compatibility no-op
            case 'q': do_vibrate = 0;        break;
            case 'B': do_broadcast = 1;      break;
            case '?': printf("\n");
            case 'h':
                usage();
                exit(1);
        }
    }
    if (!logcat && !radio && !dmesg && !last_kmsg) {
        printf("\nAt least one of -mrdk must be specified\n");
        usage();
        exit(1);
    }

    // If we are going to use a socket, do it as early as possible
    // to avoid timeouts.
    if (use_socket) {
        redirect_to_socket(stdout, "dumplogcat");
    }

    FILE *vibrator = 0;
    if (do_vibrate) {
        vibrator = fopen("/sys/class/timed_output/vibrator/enable", "we");
        if (vibrator) {
            vibrate(vibrator, 150);
        }
    }

    if (prctl(PR_SET_KEEPCAPS, 1) < 0) {
        ALOGE("prctl(PR_SET_KEEPCAPS) failed: %s\n", strerror(errno));
        return -1;
    }

    /* switch to non-root user and group */
    gid_t groups[] = { AID_LOG, AID_SDCARD_R, AID_SDCARD_RW,
            AID_MOUNT, AID_INET, AID_NET_BW_STATS };
    if (setgroups(sizeof(groups)/sizeof(groups[0]), groups) != 0) {
        ALOGE("Unable to setgroups, aborting: %s\n", strerror(errno));
        return -1;
    }
    if (setgid(AID_SYSTEM) != 0) {
        ALOGE("Unable to setgid, aborting: %s\n", strerror(errno));
        return -1;
    }
    if (setuid(AID_SYSTEM) != 0) {
        ALOGE("Unable to setuid, aborting: %s\n", strerror(errno));
        return -1;
    }

    struct __user_cap_header_struct capheader;
    struct __user_cap_data_struct capdata[2];
    memset(&capheader, 0, sizeof(capheader));
    memset(&capdata, 0, sizeof(capdata));
    capheader.version = _LINUX_CAPABILITY_VERSION_3;
    capheader.pid = 0;

    capdata[CAP_TO_INDEX(CAP_SYSLOG)].permitted = CAP_TO_MASK(CAP_SYSLOG);
    capdata[CAP_TO_INDEX(CAP_SYSLOG)].effective = CAP_TO_MASK(CAP_SYSLOG);
    capdata[0].inheritable = 0;
    capdata[1].inheritable = 0;

    if (capset(&capheader, &capdata[0]) < 0) {
        ALOGE("capset failed: %s\n", strerror(errno));
        return -1;
    }

    char path[PATH_MAX], tmp_path[PATH_MAX];

    if (!use_socket && use_outfile) {
        strlcpy(path, use_outfile, sizeof(path));
        if (do_add_date) {
            char date[80];
            time_t now = time(NULL);
            strftime(date, sizeof(date), "-%Y-%m-%d-%H-%M-%S", localtime(&now));
            strlcat(path, date, sizeof(path));
        }
        strlcat(path, ".txt", sizeof(path));
        strlcpy(tmp_path, path, sizeof(tmp_path));
        strlcat(tmp_path, ".tmp", sizeof(tmp_path));
        redirect_to_file(stdout, tmp_path, 0);
    }

    if (logcat) {
        timeout = logcat_timeout("main") + logcat_timeout("system") + logcat_timeout("crash");
        if (timeout < 20000) {
            timeout = 20000;
        }
        run_command("SYSTEM LOG", timeout / 1000, "logcat", "-v", "threadtime", "-d", "*:v", NULL);
    }

    if (radio) {
        timeout = logcat_timeout("radio");
        if (timeout < 20000) {
            timeout = 20000;
        }
        run_command("RADIO LOG", timeout / 1000, "logcat", "-b", "radio", "-v", "threadtime", "-d", "*:v", NULL);
    }

    if (dmesg) {
        do_dmesg();
    }

    if (last_kmsg) {
        struct stat st;
        if (!stat(PSTORE_LAST_KMSG, &st)) {
            /* Also TODO: Make console-ramoops CAP_SYSLOG protected. */
            dump_file("LAST KMSG", PSTORE_LAST_KMSG);
        } else if (!stat(ALT_PSTORE_LAST_KMSG, &st)) {
            dump_file("LAST KMSG", ALT_PSTORE_LAST_KMSG);
#ifdef USES_ALT_KMSG_LOCATION
        } else if (!stat(USES_ALT_KMSG_LOCATION, &st)) {
            dump_file("LAST KMSG", USES_ALT_KMSG_LOCATION);
#endif
        } else {
            /* TODO: Make last_kmsg CAP_SYSLOG protected. b/5555691 */
            dump_file("LAST KMSG", "/proc/last_kmsg");
        }
    }

    if (vibrator) {
        for (int i = 0; i < 3; i++) {
            vibrate(vibrator, 75);
            usleep((75 + 50) * 1000);
        }
        fclose(vibrator);
    }

    /* rename the (now complete) .tmp file to its final location */
    if (use_outfile && rename(tmp_path, path)) {
        fprintf(stderr, "rename(%s, %s): %s\n", tmp_path, path, strerror(errno));
    }

    if (do_broadcast && use_outfile) {
        run_command(NULL, 5, "/system/bin/am", "broadcast", "--user", "0",
                "-a", "com.evervolv.toolbox.action.DUMPLOGCAT_FINISHED",
                "--es", "com.evervolv.toolbox.intent.extra.LOGCAT", path,
                "--receiver-permission", "com.evervolv.toolbox.permission.DUMPLOGCAT", NULL);
    }

    return 0;
}
