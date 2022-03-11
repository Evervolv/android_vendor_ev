# Inherit common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common.mk)

# Required packages
PRODUCT_PACKAGES += \
    androidx.window.extensions
