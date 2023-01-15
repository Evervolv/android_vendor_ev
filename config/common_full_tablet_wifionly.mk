# Inherit common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    androidx.window.extensions

# Sound
include $(SRC_EVERVOLV_DIR)/config/aosp_audio.mk
