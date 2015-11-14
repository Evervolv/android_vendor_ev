# Audio
PRODUCT_PACKAGES += \
    AudioFX \
    Eleven

# Chromium Browser
PRODUCT_PACKAGES += \
    Chromium

# Evervolv packages
PRODUCT_PACKAGES += \
    EVToolbox \
    EVUpdater \
    EVTips \
    EVWidgets \
    EVWallpapers

# Theme engine
PRODUCT_PACKAGES += \
    aapt \
    ThemeChooser \
    ThemesProvider

# Stagefright FFMPEG plugin
 PRODUCT_PACKAGES += \
     libstagefright_soft_ffmpegadec \
     libstagefright_soft_ffmpegvdec \
     libFFmpegExtractor \
     media_codecs_ffmpeg.xml

# Command line tools
PRODUCT_PACKAGES += \
    bash \
    busybox \
    ca-bundle \
    curl \
    dumplogcat \
    e2fsck \
    mke2fs \
    resize2fs \
    rsync \
    scp \
    sftp \
    ssh \
    ssh-keygen \
    sshd \
    sshd_config \
    sshd_motd \
    start-ssh \
    su \
    tune2fs \
    vim \
    vimrc \
    wget

# Init
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init.evervolv.rc:root/init.evervolv.rc \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init.superuser.rc:root/init.superuser.rc

# Init.d
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/sysinit:system/bin/sysinit \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init.d/01sysctl:system/etc/init.d/01sysctl \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init.d/05mountext:system/etc/init.d/05mountext \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init.d/20extgapps:system/etc/init.d/20extgapps

# Apps2sd
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/a2sd:system/bin/a2sd \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/fix_permissions:system/bin/fix_permissions \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/xbin/zipalign:system/xbin/zipalign \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init.d/10apps2sd-redux:system/etc/init.d/10apps2sd

# MOTD
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/welcome_motd:system/bin/welcome_motd
