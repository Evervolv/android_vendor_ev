# Inherit common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    androidx.window.extensions

# Permissions
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Sound
include $(SRC_EVERVOLV_DIR)/config/aosp_audio.mk

# Themes
PRODUCT_PACKAGES += \
    ThemePicker \
    ThemesStub
