# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    Launcher3QuickStep

# Extra tools
PRODUCT_PACKAGES += \
    awk \
    bash \
    bzip2 \
    curl \
    lib7z \
    libsepol \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh \
    unzip \
    zip

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Fonts
$(call inherit-product-if-exists, external/google-fonts/lato/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/rubik/fonts.mk)

PRODUCT_PACKAGES += \
    fonts_customization.xml \
    PlatformLatoFont \
    PlatformRubikFont

# Themes
PRODUCT_PACKAGES += \
    PlatformBlackAccent \
    PlatformBlueAccent \
    PlatformCyanAccent \
    PlatformGreenAccent \
    PlatformOrangeAccent \
    PlatformPinkAccent \
    PlatformRedAccent \
    PlatformYellowAccent \
    PlatformBlackTheme \
    PlatformThemesStub \
    ThemePicker

# Extra packages
PRODUCT_PACKAGES += \
    Email \
    Jelly \
    WallpaperPicker

# Root
PRODUCT_PACKAGES += \
    adb_root
