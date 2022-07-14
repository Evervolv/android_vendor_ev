# Browser
PRODUCT_PACKAGES += \
    Jelly

# Calculator
PRODUCT_PACKAGES += \
    ExactCalculator

# DeviceConfig
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    Launcher3QuickStep

# Email
PRODUCT_PACKAGES += \
    Etar

# Fonts
$(call inherit-product-if-exists, external/google-fonts/lato/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/rubik/fonts.mk)

# Overlays
PRODUCT_PACKAGES += \
    PlatformDocumentsUIOverlay \
    PlatformLauncher3Overlay \
    PlatformSettingsOverlay \
    PlatformThemePickerOverlay

# Themes
PRODUCT_PACKAGES += \
    PixelThemesStub \
    PlatformThemesStub \
    ThemePicker \
    WallpaperPicker
