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
    tune2fs \
    vim \
    vimrc

# Custom init script
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init.evervolv.rc:root/init.evervolv.rc

# Utilize init.d scripts
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/sysinit:system/bin/sysinit \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init.d/01sysctl:system/etc/init.d/01sysctl \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init.d/05mountext:system/etc/init.d/05mountext \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init.d/20extgapps:system/etc/init.d/20extgapps

# Apps2sd files
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/a2sd:system/bin/a2sd \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/fix_permissions:system/bin/fix_permissions \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/xbin/zipalign:system/xbin/zipalign \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/init.d/10apps2sd-redux:system/etc/init.d/10apps2sd

# Misc files
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/bin/welcome_motd:system/bin/welcome_motd
