PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.build.selinux=1 \
    persist.sys.disable_rescue=true

PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/sysinit:system/bin/sysinit

# Init file
PRODUCT_PACKAGES += \
    init.evervolv.rc

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/mkshrc:system/etc/mkshrc

# Overlays
PRODUCT_PACKAGE_OVERLAYS += $(SRC_EVERVOLV_DIR)/overlay

# Branding
include $(SRC_EVERVOLV_DIR)/config/branding.mk

# Packages
include $(SRC_EVERVOLV_DIR)/config/packages.mk

# Sounds
$(call inherit-product-if-exists, vendor/google/GoogleAudio.mk)
