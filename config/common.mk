# ADB authentication.
ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1
else
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=0
endif

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

# Branding
include $(SRC_EVERVOLV_DIR)/config/branding.mk

# Build date override
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Build information
PRODUCT_OVERRIDE_FINGERPRINT ?= google/redfin/redfin:12/SP2A.220305.012/8177914:user/release-keys

# Debug
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD ?= false
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO ?= true
endif

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    Launcher3QuickStep

# Init
$(foreach f,$(wildcard $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init/*.rc),\
       $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/$(notdir $f)))

# Overlays
PRODUCT_PACKAGES += \
    NavigationBarMode2ButtonOverlay \
    PlatformFrameworksOverlay \
    PlatformDialerOverlay \
    PlatformDocumentsUIOverlay \
    PlatformLauncher3Overlay \
    PlatformSettingsOverlay \
    PlatformSettingsProviderOverlay \
    PlatformDeviceConfigOverlay \
    PlatformSystemUIOverlay \
    PlatformTelephonyOverlay \
    PlatformThemePickerOverlay \
    PlatformThemesStub

# Packages
PRODUCT_PACKAGES += \
    adb_root \
    Etar \
    Jelly \
    SimpleDeviceConfig \
    ThemePicker \
    WallpaperPicker

# Permissions
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/sysconfig/sysconfig.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/evervolv-sysconfig.xml

# Properties
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    media.recorder.show_manufacturer_and_model=true \
    persist.sys.disable_rescue=true \
    ro.control_privapp_permissions=enforce \
    ro.storage_manager.enabled=true

# Sound
include $(SRC_EVERVOLV_DIR)/config/aosp_audio.mk

# Vendor Mobile Services
ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif
