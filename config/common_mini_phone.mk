# Inherit mobile mini common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common_mobile_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/telephony.mk)
