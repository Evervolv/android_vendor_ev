# Build CellBroadcastReceiver
PRODUCT_PACKAGES += \
    CellBroadcastReceiver

# Enable CellBroadcastReceiver settings
PRODUCT_PACKAGE_OVERLAYS += $(SRC_EVERVOLV_DIR)/overlay/phone

# Inherit common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common.mk)

