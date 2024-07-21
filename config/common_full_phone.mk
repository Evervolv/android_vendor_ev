# Inherit mobile full common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common_mobile_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += $(SRC_EVERVOLV_DIR)/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(SRC_EVERVOLV_DIR)/overlay/dictionaries

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true

$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/telephony.mk)
