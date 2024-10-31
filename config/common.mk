# Allow vendor/extra to override any property by setting it first
-include vendor/extra/product.mk

# ADB
PRODUCT_PACKAGES += \
    adb_root

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

# Bootanimation
TARGET_SCREEN_WIDTH ?= 1080
TARGET_SCREEN_HEIGHT ?= 1920

# Component overrides
PRODUCT_PACKAGES += \
    evervolv-component-overrides.xml

# DeviceConfig
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Evervolv
EV_PRODUCT_BUILD ?= userbuild

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/etc/permissions/com.evervolv.platform.xml \
    system/framework/oat/%/com.evervolv.platform.odex \
    system/framework/oat/%/com.evervolv.platform.vdex \
    system/framework/com.evervolv.platform-res.apk \
    system/framework/com.evervolv.platform.jar

PRODUCT_PACKAGES += \
    bootanimation.zip \
    com.evervolv.platform-res \
    com.evervolv.platform \
    EVSettingsProvider \
    EVSetupWizard \
    EVToolbox

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.evervolv.build.version.plat.sdk=4 \
    ro.evervolv.build.version.plat.rev=0

# Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(SRC_EVERVOLV_DIR)/overlay/no-rro
PRODUCT_PACKAGE_OVERLAYS += \
    $(SRC_EVERVOLV_DIR)/overlay/common \
    $(SRC_EVERVOLV_DIR)/overlay/no-rro

# Security
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(SRC_EVERVOLV_DIR)/build/target/product/security/lineage

ifneq ($(wildcard vendor/ev-priv/keys/keys.mk),)
    include vendor/ev-priv/keys/keys.mk
else ifneq ($(wildcard vendor/lineage-priv/keys/keys.mk),)
    include vendor/lineage-priv/keys/keys.mk
else
    include $(SRC_EVERVOLV_DIR)/build/target/product/certificate.mk
endif

# System
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD ?= false
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO ?= true
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.systemuicompilerfilter=speed \
    keyguard.no_require_sim=true \
    persist.sys.disable_rescue=true \
    persist.sys.strictmode.disable=$(if $(filter eng,$(TARGET_BUILD_VARIANT)),false,true) \
    ro.adb.secure=$(if $(filter user,$(TARGET_BUILD_VARIANT)),1,0) \
    ro.ota.allow_downgrade=$(if $(filter user,$(TARGET_BUILD_VARIANT)),false,true) \
    ro.storage_manager.enabled=true

# Vendor Mobile Services
include $(SRC_EVERVOLV_DIR)/config/partner_gms.mk

# Vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Wallpaper
PRODUCT_PACKAGES += \
    DefaultWallpaperOverlay

