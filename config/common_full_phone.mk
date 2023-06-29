# Inherit common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common_full.mk)
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/telephony.mk)

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true

# Permissions
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Sound
include $(SRC_EVERVOLV_DIR)/config/aosp_audio.mk

# Themes
include $(SRC_EVERVOLV_DIR)/config/overlays.mk

PRODUCT_PACKAGES += \
    RepainterServicePriv \
    ThemePicker \
    ThemesStub
