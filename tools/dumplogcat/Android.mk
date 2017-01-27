LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

ifneq ($(BOARD_USES_ALT_KMSG_LOCATION),)
LOCAL_CFLAGS += -DUSES_ALT_KMSG_LOCATION='$(BOARD_USES_ALT_KMSG_LOCATION)'
endif
LOCAL_SRC_FILES := dumplogcat.cpp utils.cpp

LOCAL_MODULE := dumplogcat

LOCAL_SHARED_LIBRARIES := libcutils liblog

LOCAL_CFLAGS += -Wall -Werror -Wno-unused-parameter

LOCAL_INIT_RC := dumplogcat.rc

include $(BUILD_EXECUTABLE)
