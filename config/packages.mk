# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI

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

# Themes
PRODUCT_PACKAGES += \
    PlatformBlackAccent \
    PlatformBlueAccent \
    PlatformBrownAccent \
    PlatformCyanAccent \
    PlatformGreenAccent \
    PlatformOrangeAccent \
    PlatformPinkAccent \
    PlatformPurpleAccent \
    PlatformRedAccent \
    PlatformYellowAccent \
    PlatformThemesStub \
    ThemePicker

# Extra packages
PRODUCT_PACKAGES += \
    AudioFX \
    Eleven \
    Jelly \
    WallpaperPicker

# Root
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    adb_root
endif
