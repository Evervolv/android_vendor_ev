#
# This policy configuration will be used by all qcom products
# that inherit from Lineage
#

BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    $(SRC_EVERVOLV_DIR)/sepolicy/qcom/private

BOARD_SEPOLICY_DIRS += \
    $(SRC_EVERVOLV_DIR)/sepolicy/qcom/common \
    $(SRC_EVERVOLV_DIR)/sepolicy/qcom/$(TARGET_BOARD_PLATFORM)
