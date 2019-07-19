ifeq ($(TARGET_COPY_OUT_VENDOR), vendor)
ifeq ($(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE),)
TARGET_USES_PREBUILT_VENDOR_SEPOLICY ?= true
endif
endif

BOARD_PLAT_PUBLIC_SEPOLICY_DIR += \
    $(SRC_EVERVOLV_DIR)/sepolicy/common/public

BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    $(SRC_EVERVOLV_DIR)/sepolicy/common/private

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    $(SRC_EVERVOLV_DIR)/sepolicy/common/dynamic
else
BOARD_SEPOLICY_DIRS += \
    $(SRC_EVERVOLV_DIR)/sepolicy/common/dynamic \
    $(SRC_EVERVOLV_DIR)/sepolicy/common/vendor
endif
