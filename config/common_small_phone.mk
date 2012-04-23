# Inherit common stuff
$(call inherit-product, vendor/ev/config/common.mk)
$(call inherit-product, vendor/ev/config/common_small.mk)

PRODUCT_PACKAGES += \
    Mms
