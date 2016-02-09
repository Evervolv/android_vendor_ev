PRODUCT_BRAND ?= evervolv

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/ev/prebuilt/common/bin/backuptool/backuptool.sh:install/bin/backuptool.sh \
    vendor/ev/prebuilt/common/bin/backuptool/backuptool.functions:install/bin/backuptool.functions \
    vendor/ev/prebuilt/common/bin/backuptool/50-cm.sh:system/addon.d/50-cm.sh \
    vendor/ev/prebuilt/common/bin/backuptool/blacklist:system/addon.d/blacklist

# Make sure our default sounds make it in.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Pyxis.ogg \
    ro.config.notification_sound=Merope.ogg \
    ro.config.alarm_alert=Scandium.ogg

FW_SNDS_PATH := frameworks/base/data/sounds
PRODUCT_COPY_FILES += \
    $(FW_SNDS_PATH)/ringtones/ogg/Pyxis.ogg:system/media/audio/ringtones/Pyxis.ogg \
    $(FW_SNDS_PATH)/notifications/Merope.ogg:system/media/audio/notifications/Merope.ogg \
    $(FW_SNDS_PATH)/alarms/ogg/Scandium.ogg:system/media/audio/alarms/Scandium.ogg

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Theme engine
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/permissions/org.cyanogenmod.theme.xml:system/etc/permissions/org.cyanogenmod.theme.xml

# Backup Transport
PRODUCT_PACKAGE_OVERLAYS += $(SRC_EVERVOLV_DIR)/overlay/common

# Disable strict mode
ADDITIONAL_DEFAULT_PROPERTIES += \
    persist.sys.strictmode.disable=true

# SELinux
PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Apps / Commandline / Init stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/tools.mk)

# LatinIME english dictionary
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/dictionaries/english.mk)

# Hot reboot
PRODUCT_PACKAGE_OVERLAYS += vendor/ev/overlay/hot_reboot

# Check if set to valid option
ifneq ($(filter 720p 1080p 1440p hvga qhd wvga xga,$(BOOT_ANIMATION_SIZE)),)
PRODUCT_COPY_FILES += \
    vendor/ev/prebuilt/bootanimation/$(BOOT_ANIMATION_SIZE).zip:system/media/bootanimation.zip
else
$(warning ************************************************************)
$(warning BOOT_ANIMATION_SIZE is either null or invalid.)
$(warning Choices are 720p, 1080p, 1440p, hvga, qhd, wvga, and xga.)
$(warning Please update your device tree to a valid choice.)
$(warning Otherwise, no animation will be present.)
$(warning ************************************************************)
endif

#
# Version Info
#

ifneq ($(APPEND_ZIP_VERSION),)
APPEND_ZIP=-$(APPEND_ZIP_VERSION)
endif

ifeq ($(NIGHTLY_BUILD),true)
  ROM_VERSION := $(TARGET_PRODUCT)-$(PLATFORM_VERSION)-nightly-$(shell date +%Y.%m.%d)$(APPEND_ZIP)
else ifeq ($(TESTING_BUILD),true)
  ROM_VERSION := $(TARGET_PRODUCT)-$(PLATFORM_VERSION)-testing-$(shell date +%Y.%m.%d)$(APPEND_ZIP)
else
  ROM_VERSION := $(TARGET_PRODUCT)-$(PLATFORM_VERSION)-userbuild-$(shell date +%Y.%m.%d)$(APPEND_ZIP)
endif

ROM_VERSION := $(shell echo ${ROM_VERSION} | tr [:upper:] [:lower:])

PRODUCT_PROPERTY_OVERRIDES += \
    ro.evervolv.device=$(PRODUCT_CODENAME) \
    ro.evervolv.version=$(ROM_VERSION)

