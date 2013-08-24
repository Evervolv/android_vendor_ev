LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := dumplogcat.c utils.c

LOCAL_MODULE := dumplogcat

LOCAL_SHARED_LIBRARIES := libcutils liblog

LOCAL_CFLAGS += -Wall -Wno-unused-parameter -std=gnu99

include $(BUILD_EXECUTABLE)
