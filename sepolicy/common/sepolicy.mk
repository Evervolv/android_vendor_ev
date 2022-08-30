ifeq ($(TARGET_COPY_OUT_VENDOR), vendor)
ifeq ($(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE),)
TARGET_USES_PREBUILT_VENDOR_SEPOLICY ?= true
endif
endif

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
ifeq ($(TARGET_HAS_FUSEBLK_SEPOLICY_ON_VENDOR),true)
BOARD_SEPOLICY_M4DEFS += board_excludes_fuseblk_sepolicy=true
endif
endif

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += \
    $(SRC_EVERVOLV_DIR)/sepolicy/common/public

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    $(SRC_EVERVOLV_DIR)/sepolicy/common/private

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    $(SRC_EVERVOLV_DIR)/sepolicy/common/dynamic
else
BOARD_VENDOR_SEPOLICY_DIRS += \
    $(SRC_EVERVOLV_DIR)/sepolicy/common/dynamic \
    $(SRC_EVERVOLV_DIR)/sepolicy/common/vendor
endif
