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

# Android Beam
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.nfc.beam.xml

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

# Downgrade
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif

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
$(foreach f,$(wildcard $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init/*.rc),\
       $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/$(notdir $f)))

# Keyguard
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true

# Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(SRC_EVERVOLV_DIR)/overlay/no-rro
PRODUCT_PACKAGE_OVERLAYS += \
    $(SRC_EVERVOLV_DIR)/overlay/no-rro

# Permissions
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/sysconfig/sysconfig.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/evervolv-sysconfig.xml

# Rescue
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.disable_rescue=true

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
ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

include $(SRC_EVERVOLV_DIR)/config/partner_gms.mk
