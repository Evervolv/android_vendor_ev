# Browser
PRODUCT_PACKAGES += \
    Jelly

# Extra tools
PRODUCT_PACKAGES += \
    e2fsck \
    htop \
    mke2fs \
    nano \
    openvpn \
    tune2fs \
    wget

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Music
PRODUCT_PACKAGES += \
    AudioFX \
    Eleven

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Themes
PRODUCT_PACKAGES += \
    PixelTheme \
    StockTheme

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.boot.vendor.overlay.theme=com.google.android.theme.pixel

# Updater
PRODUCT_PACKAGES += \
    EVUpdater

# Wallpaper picker
PRODUCT_PACKAGES += \
    WallpaperPicker
