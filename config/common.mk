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

PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Pyxis.ogg \
    ro.config.notification_sound=Merope.ogg \
    ro.config.alarm_alert=Scandium.ogg

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Required packages
PRODUCT_PACKAGES += \
    LatinIME \
    Superuser \
    su

# Optional packages
PRODUCT_PACKAGES += \
    AndroidTerm \
    EVToolbox \
    EVWidgets

# Utilize init.d scripts
PRODUCT_COPY_FILES += \
    vendor/ev/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/ev/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/ev/prebuilt/common/etc/init.d/01sysctl:system/etc/init.d/01sysctl \
    vendor/ev/prebuilt/common/etc/init.d/05mountext:system/etc/init.d/05mountext

# Apps2sd files
PRODUCT_COPY_FILES += \
    vendor/ev/prebuilt/common/bin/a2sd:system/bin/a2sd \
    vendor/ev/prebuilt/common/bin/fix_permissions:system/bin/fix_permissions \
    vendor/ev/prebuilt/common/xbin/zipalign:system/xbin/zipalign \
    vendor/ev/prebuilt/common/etc/init.d/10apps2sd-redux:system/etc/init.d/10apps2sd

# Prebuilt commandline tools
PRODUCT_COPY_FILES += \
    vendor/ev/prebuilt/common/xbin/dropbear-keygen:system/xbin/dropbear-keygen \
    vendor/ev/prebuilt/common/xbin/htop:system/xbin/htop \
    vendor/ev/prebuilt/common/xbin/powertop:system/xbin/powertop \
    vendor/ev/prebuilt/common/etc/profile:system/etc/profile \
    vendor/ev/prebuilt/common/etc/terminfo/l/linux:system/etc/terminfo/l/linux \
    vendor/ev/prebuilt/common/etc/terminfo/u/unknown:system/etc/terminfo/u/unknown

PRODUCT_PACKAGE_OVERLAYS += vendor/ev/overlay/wallpapers
PRODUCT_PACKAGE_OVERLAYS += vendor/ev/overlay/common

# Disable strict mode
ADDITIONAL_DEFAULT_PROPERTIES += \
    persist.sys.strictmode.disable=true

# Version Info
PRODUCT_VERSION_MAJOR = 2
PRODUCT_VERSION_MINOR = 2
PRODUCT_VERSION_MAINTENANCE = 0

ifeq ($(NIGHTLY_BUILD),true)
    ROM_VERSION := Evervolv-$(PRODUCT_CODENAME)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(shell date +%Y%m%d)
else
    ROM_VERSION := Evervolv-$(PRODUCT_CODENAME)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.romversion=$(ROM_VERSION)
