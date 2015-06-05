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

# SDK
ifndef EV_PLATFORM_SDK_VERSION
  # This is the canonical definition of the SDK version, which defines
  # the set of APIs and functionality available in the platform.  It
  # is a single integer that increases monotonically as updates to
  # the SDK are released.  It should only be incremented when the APIs for
  # the new release are frozen (so that developers don't write apps against
  # intermediate builds).
  EV_PLATFORM_SDK_VERSION := 1
endif

ifndef EV_PLATFORM_REV
  # For internal SDK revisions that are hotfixed/patched
  # Reset after each EV_PLATFORM_SDK_VERSION release
  # If you are doing a release and this is NOT 0, you are almost certainly doing it wrong
  EV_PLATFORM_REV := 0
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.evervolv.build.version.plat.sdk=$(EV_PLATFORM_SDK_VERSION) \
  ro.evervolv.build.version.plat.rev=$(EV_PLATFORM_REV)

PRODUCT_PACKAGES += \
    com.evervolv.platform-res \
    com.evervolv.platform \
    com.evervolv.platform.xml \
    EVSettingsProvider

# Themes
PRODUCT_PACKAGES += \
    PixelTheme \
    StockTheme

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.boot.vendor.overlay.theme=com.google.android.theme.pixel
