# Allow vendor/extra to override any property by setting it first
-include vendor/extra/product.mk

# ADB
PRODUCT_PACKAGES += \
    adb_root

# ADB authentication, only applied on user builds.
ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1
else
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=0
endif

# Allow duplicate files 
BUILD_BROKEN_DUP_RULES ?= true

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

# Build date override
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

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

PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init/init.openssh.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/init.openssh.rc

# Debug
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD ?= false
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO ?= true
endif

# DeviceConfig
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Downgrade
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif

# Evervolv
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
    EVToolbox \
    EVUpdater

# Filesystems
PRODUCT_PACKAGES += \
    fsck.ntfs \
    mkfs.ntfs \
    mount.ntfs

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/fsck.ntfs \
    system/bin/mkfs.ntfs \
    system/bin/mount.ntfs \
    system/%/libfuse-lite.so \
    system/%/libntfs-3g.so

# Init
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init/init.evervolv-system_ext.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.evervolv-system_ext.rc

# Keyguard
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true

# Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(SRC_EVERVOLV_DIR)/overlay/no-rro
PRODUCT_PACKAGE_OVERLAYS += \
    $(SRC_EVERVOLV_DIR)/overlay/common \
    $(SRC_EVERVOLV_DIR)/overlay/no-rro

# Overlays
PRODUCT_PACKAGES += \
    FrameworkResEvervolv \
    DocumentsUIResEvervolv

PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/overlay/partition_order.xml:$(TARGET_COPY_OUT_PRODUCT)/overlay/partition_order.xml

# Rescue
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.disable_rescue=true

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

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# StrictMode
ifneq ($(TARGET_BUILD_VARIANT),eng)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.strictmode.disable=true
endif

# SystemUI
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.systemuicompilerfilter=speed

# Vendor Mobile Services
include $(SRC_EVERVOLV_DIR)/config/partner_gms.mk

# Vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

