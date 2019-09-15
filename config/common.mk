PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    persist.sys.disable_rescue=true

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0
endif

PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/sysinit:system/bin/sysinit

# Backup tool
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/50-backup.sh:system/addon.d/50-backup.sh

# Init file
$(foreach f,$(wildcard $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Permissions for our apps
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/permissions/privapp-permissions.xml:system/etc/permissions/privapp-permissions-evervolv.xml \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/permissions/privapp-permissions-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-evervolv-product.xml \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/permissions/hiddenapi-package-whitelist.xml:system/etc/permissions/evervolv-hiddenapi-package-whitelist.xml \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/sysconfig/power-whitelist.xml:system/etc/sysconfig/evervolv-power-whitelist.xml \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/sysconfig/sysconfig.xml:system/etc/sysconfig/evervolv-sysconfig.xml

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(SRC_EVERVOLV_DIR)/overlay
DEVICE_PACKAGE_OVERLAYS += $(SRC_EVERVOLV_DIR)/overlay/common

# AOSP audio files
include $(SRC_EVERVOLV_DIR)/config/aosp_audio.mk

# Branding
include $(SRC_EVERVOLV_DIR)/config/branding.mk

# Packages
include $(SRC_EVERVOLV_DIR)/config/packages.mk
