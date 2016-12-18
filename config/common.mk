# Evervolv
PRODUCT_BRAND ?= evervolv

# Default propety overrides
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.build.selinux=1 \
    persist.sys.strictmode.disable=true \
    ro.substratum.verified=true \
    ro.opa.eligible_device=true

# Disable UTC date
PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_UTC_DATE=0

# Overlays
PRODUCT_PACKAGE_OVERLAYS += $(SRC_EVERVOLV_DIR)/overlay/common

# Check BOOT_ANIMATION_SIZE for a valid size
ifneq ($(filter 720p 1080p 1440p hvga qhd wvga xga,$(BOOT_ANIMATION_SIZE)),)
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/bootanimation/$(BOOT_ANIMATION_SIZE).zip:system/media/bootanimation.zip
else
$(warning ************************************************************)
$(warning BOOT_ANIMATION_SIZE is either null or invalid.)
$(warning Choices are 720p, 1080p, 1440p, hvga, qhd, wvga, and xga.)
$(warning Please update your device tree to a valid choice.)
$(warning Otherwise, no animation will be present.)
$(warning ************************************************************)
endif

# Apps / Commandline / Init stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/tools.mk)

# LatinIME english dictionary
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/dictionaries/english.mk)

# Version Info
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

