$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/telephony.mk)
