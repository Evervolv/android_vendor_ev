# Inherit common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common.mk)

# Audio
PRODUCT_PACKAGES += \
    AudioFX

# Browser
PRODUCT_PACKAGES += \
    Jelly

# Calculator
PRODUCT_PACKAGES += \
    ExactCalculator

# Camera
PRODUCT_PACKAGES += \
    Aperture

# Charger
PRODUCT_PACKAGES += \
    lineage_charger_animation \
    lineage_charger_animation_vendor

# DeviceConfig
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Email
PRODUCT_PACKAGES += \
    Etar

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Overlays
PRODUCT_PACKAGES += \
    FrameworkResEvervolv \
    DocumentsUIResEvervolv \
    Launcher3ResEvervolv \
    NavigationBarMode2ButtonOverlay

ifeq ($(WITH_SNET_BYPASS),true)
PRODUCT_PACKAGES += \
    FrameworkResGmsCompat
endif

# Permissions
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Sound
include $(SRC_EVERVOLV_DIR)/config/aosp_audio.mk

# Themes
include $(SRC_EVERVOLV_DIR)/config/overlays.mk
PRODUCT_PACKAGES += \
    Backgrounds
