# ADB
PRODUCT_PACKAGES += \
    adb_root

# ADB authentication.
ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1
else
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=0
endif

# Allow duplicate files 
BUILD_BROKEN_DUP_RULES ?= true

# Android Beam
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.nfc.beam.xml

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true
PRODUCT_PRODUCT_PROPERTIES += \
    ro.apex.updatable=false

# Backup tool
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/50-backup.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-backup.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/addon.d/50-backup.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/backuptool_ab.sh \
    system/bin/backuptool_ab.functions \
    system/bin/backuptool_postinstall.sh
endif

# Blurs
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1

# Branding
include $(SRC_EVERVOLV_DIR)/config/branding.mk

# Browser
PRODUCT_PACKAGES += \
    Jelly

# Build date override
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Build information
PRODUCT_OVERRIDE_FINGERPRINT ?= google/redfin/redfin:12/SP1A.210812.016.A1/7796139:user/release-keys

# Command line
PRODUCT_PACKAGES += \
    bash \
    curl \
    lib7z \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh \
    unzip \
    zip

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/curl

# Debug
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD ?= false
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO ?= true
endif

# DeviceConfig
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    Launcher3QuickStep

# Init
$(foreach f,$(wildcard $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init/*.rc),\
       $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/$(notdir $f)))

# Keyguard
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Navigation
PRODUCT_PACKAGES += \
    NavigationBarMode2ButtonOverlay

# Overlays
PRODUCT_PACKAGES += \ \
    PlatformFrameworksOverlay \
    PlatformDialerOverlay \
    PlatformDocumentsUIOverlay \
    PlatformLauncher3Overlay \
    PlatformSettingsOverlay \
    PlatformSettingsProviderOverlay \
    PlatformDeviceConfigOverlay \
    PlatformSystemUIOverlay \
    PlatformTelephonyOverlay \
    PlatformThemePickerOverlay

# Permissions
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/sysconfig/sysconfig.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/evervolv-sysconfig.xml

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Prefetching
PRODUCT_PRODUCT_PROPERTIES += \
    ro.iorapd.enable=true

# Release tools
PRODUCT_MOTD ?="\n"

# Rescue
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.disable_rescue=true

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Sound
include $(SRC_EVERVOLV_DIR)/config/aosp_audio.mk

# StrictMode
ifneq ($(TARGET_BUILD_VARIANT),eng)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.strictmode.disable=true
endif

# Themes
PRODUCT_PACKAGES += \
    PlatformThemesStub \
    ThemePicker \
    WallpaperPicker

# Vendor Mobile Services
ifeq ($(WITH_GMS),true)

$(call inherit-product-if-exists, vendor/google/gms/config.mk)
ifeq ($(TARGET_FLATTEN_APEX), false)
$(call inherit-product-if-exists, vendor/google/modules/build/mainline_modules_r.mk)
else
$(call inherit-product-if-exists, vendor/google/modules/build/mainline_modules_r_flatten_apex.mk)
endif
$(call inherit-product-if-exists, vendor/google/pixel/config.mk)

else

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

endif
