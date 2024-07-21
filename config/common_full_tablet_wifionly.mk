$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit mobile full common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common_mobile_full.mk)

# Settings
PRODUCT_PRODUCT_PROPERTIES += \
    persist.settings.large_screen_opt.enabled=true

$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/wifionly.mk)
