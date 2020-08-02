# Inherit common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common.mk)

# Browser
PRODUCT_PACKAGES += \
    Jelly

# Calculator
PRODUCT_PACKAGES += \
    ExactCalculator

# DeviceConfig
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Email
PRODUCT_PACKAGES += \
    Etar

# Fonts
$(call inherit-product-if-exists, external/google-fonts/lato/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/rubik/fonts.mk)

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Overlays
PRODUCT_PACKAGES += \
    PixelSettingsOverlay \
    PlatformLauncher3Overlay

# Themes
PRODUCT_PACKAGES += \
    PlatformThemePickerOverlay \
    PlatformThemesStub \
    ThemePicker \
    WallpaperPicker
