# ADB authentication, only applied on nightly/testing/release builds.
ifneq ($(filter nightly testing release,$(PRODUCT_BUILD)),)
ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1
else
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=0
endif
endif

# Boot animation
BOOT_ANIMATION_SIZE ?= 1080p
ifneq ($(filter 720p 1080p 1440p hvga qhd wvga xga,$(BOOT_ANIMATION_SIZE)),)
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/bootanimation/$(BOOT_ANIMATION_SIZE).zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/media/bootanimation.zip
endif

# AOSP has no support of loading framework resources from /system_ext
# so the SDK has to stay in /system for now
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/etc/permissions/com.evervolv.globalactions.xml \
    system/etc/permissions/com.evervolv.hardware.xml \
    system/etc/permissions/com.evervolv.livedisplay.xml \
    system/etc/permissions/com.evervolv.platform.xml \
    system/framework/oat/%/com.evervolv.platform.odex \
    system/framework/oat/%/com.evervolv.platform.vdex \
    system/framework/com.evervolv.platform-res.apk \
    system/framework/com.evervolv.platform.jar

# SDK
EV_PLATFORM_SDK_VERSION ?= 4
EV_PLATFORM_REV ?= 0

PRODUCT_PACKAGES += \
    com.evervolv.globalactions.xml \
    com.evervolv.hardware.xml \
    com.evervolv.livedisplay.xml \
    com.evervolv.platform-res \
    com.evervolv.platform \
    com.evervolv.platform.xml \
    EVSettingsProvider \
    EVToolbox \
    EVUpdater

# Version Info
ifeq ($(SKIP_VERBOSE_DATE),true)
EV_BUILD_DATE := $(shell date +%Y.%m.%d)
endif
EV_BUILD_DATE ?= $(shell date +%Y.%m.%d)-$(shell date -u +%H%M)

ifneq ($(filter nightly testing release,$(PRODUCT_BUILD)),)
EV_BUILD_TYPE := $(PRODUCT_BUILD)
endif
EV_BUILD_TYPE ?= userbuild

EV_VERSION := $(PLATFORM_VERSION)

EV_PACKAGE_NAME ?= $(TARGET_PRODUCT)-$(EV_VERSION)-$(EV_BUILD_TYPE)-$(EV_BUILD_DATE)
TARGET_OTA_PACKAGE_NAME := $(shell echo ${EV_PACKAGE_NAME} | tr [:upper:] [:lower:])
