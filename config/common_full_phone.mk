# Inherit common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common_full.mk)
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/telephony.mk)

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true
