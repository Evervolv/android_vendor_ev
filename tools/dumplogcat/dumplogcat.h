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

#ifndef _DUMPLOGCAT_H_
#define _DUMPLOGCAT_H_

#include <time.h>
#include <unistd.h>
#include <stdbool.h>
#include <stdio.h>

#define SU_PATH "/system/xbin/su"

/* prints the contents of a file */
int dump_file(const char *title, const char* path);

/* forks a command and waits for it to finish -- terminate args with NULL */
int run_command(const char *title, int timeout_seconds, const char *command, ...);

/* redirect output to a service control socket */
void redirect_to_socket(FILE *redirect, const char *service);

/* redirect output to a file, optionally gzipping; returns gzip pid */
pid_t redirect_to_file(FILE *redirect, char *path, int gzip_level);

/* Gets the dmesg output for the kernel */
void do_dmesg();

#endif /* _DUMPLOGCAT_H_ */
