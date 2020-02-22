# Inherit common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common.mk)
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/packages.mk)
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/telephony.mk)

# Required packages
PRODUCT_PACKAGES += \
    androidx.window.extensions

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true
