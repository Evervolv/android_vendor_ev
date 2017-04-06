# Audio
PRODUCT_PACKAGES += \
    AudioFX \
    Eleven

# Battery Usage Alerts
PRODUCT_PACKAGES += \
    Turbo

# Evervolv packages
PRODUCT_PACKAGES += \
    EVToolbox \
    EVUpdater \
    init.evervolv.rc

# Substratum helper packages
PRODUCT_PACKAGES += \
    ThemeInterfacer

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Command line tools
PRODUCT_PACKAGES += \
    bash \
    ca-bundle \
    curl \
    dumplogcat \
    e2fsck \
    mke2fs \
    nano \
    resize2fs \
    rsync \
    scp \
    sysinit \
    sftp \
    ssh \
    ssh-keygen \
    sshd \
    sshd_config \
    sshd_motd \
    start-ssh \
    toybox \
    tune2fs \
    welcome_motd \
    wget

# Backup Tool
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/bin/backuptool/backuptool.sh:install/bin/backuptool.sh \
    $(SRC_EVERVOLV_DIR)/prebuilt/bin/backuptool/backuptool.functions:install/bin/backuptool.functions \
    $(SRC_EVERVOLV_DIR)/prebuilt/bin/backuptool/50-cm.sh:system/addon.d/50-cm.sh \
    $(SRC_EVERVOLV_DIR)/prebuilt/bin/backuptool/blacklist:system/addon.d/blacklist

# Init.d
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/etc/init.d/00banner:system/etc/init.d/00banner \
    $(SRC_EVERVOLV_DIR)/prebuilt/etc/init.d/01sysctl:system/etc/init.d/01sysctl \
    $(SRC_EVERVOLV_DIR)/prebuilt/etc/init.d/05mountext:system/etc/init.d/05mountext \
    $(SRC_EVERVOLV_DIR)/prebuilt/etc/init.d/20extgapps:system/etc/init.d/20extgapps
