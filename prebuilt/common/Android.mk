LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := Chromium
LOCAL_SRC_FILES := apk/$(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_CERTIFICATE := platform
LOCAL_OVERRIDES_PACKAGES := Browser
LOCAL_MULTILIB := both

include $(BUILD_PREBUILT)

# a wrapper for curl which provides wget syntax, for compatibility
include $(CLEAR_VARS)

LOCAL_MODULE := wget
LOCAL_SRC_FILES := bin/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)

include $(BUILD_PREBUILT)
