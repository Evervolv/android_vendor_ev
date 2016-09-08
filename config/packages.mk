# Extra tools
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    htop \
    lib7z \
    libsepol \
    pigz \
    powertop \
    rsync \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Extra packages
PRODUCT_PACKAGES += \
    AudioFX \
    Eleven \
    EVUpdater \
    Jelly \
    WallpaperPicker

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
