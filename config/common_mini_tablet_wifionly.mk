# Inherit mini common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/wifionly.mk)
