# Inherit common stuff
$(call inherit-product, vendor/ev/config/common.mk)
$(call inherit-product, vendor/ev/config/common_full.mk)

PRODUCT_PACKAGES += \
    Mms \
    Torch \
    CellBroadcastReceiver

