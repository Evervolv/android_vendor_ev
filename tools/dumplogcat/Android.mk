LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

ifneq ($(BOARD_USES_ALT_KMSG_LOCATION),)
LOCAL_CFLAGS += -DUSES_ALT_KMSG_LOCATION='$(BOARD_USES_ALT_KMSG_LOCATION)'
endif
LOCAL_SRC_FILES := dumplogcat.c utils.c

LOCAL_MODULE := dumplogcat

LOCAL_SHARED_LIBRARIES := libcutils liblog

LOCAL_CFLAGS += -Wall -Wno-unused-parameter -std=gnu99

include $(BUILD_EXECUTABLE)
