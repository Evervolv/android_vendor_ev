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

# Berry styles
ifeq ($(shell test $(PLATFORM_SDK_VERSION) -lt 29; echo $$?),0)
PRODUCT_PACKAGES += \
    PlatformBlackTheme \
    PlatformDarkTheme \
    PlatformBlackAccent \
    PlatformBlueAccent \
    PlatformBrownAccent \
    PlatformCyanAccent \
    PlatformGreenAccent \
    PlatformOrangeAccent \
    PlatformPinkAccent \
    PlatformPurpleAccent \
    PlatformRedAccent \
    PlatformYellowAccent
endif

# Extra packages
PRODUCT_PACKAGES += \
    AudioFX \
    Eleven \
    Jelly \
    WallpaperPicker
