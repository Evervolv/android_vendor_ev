# Command line tools

PRODUCT_PACKAGES += \
    bash \
    busybox \
    ca-bundle \
    curl \
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
    vimrc \
    wget \
    wgetrc

# Custom init script
PRODUCT_COPY_FILES += \
    vendor/ev/prebuilt/common/etc/init.evervolv.rc:root/init.evervolv.rc

# Utilize init.d scripts
PRODUCT_COPY_FILES += \
    vendor/ev/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/ev/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/ev/prebuilt/common/etc/init.d/01sysctl:system/etc/init.d/01sysctl \
    vendor/ev/prebuilt/common/etc/init.d/05mountext:system/etc/init.d/05mountext \
    vendor/ev/prebuilt/common/etc/init.d/06handleswap:system/etc/init.d/06handleswap \
    vendor/ev/prebuilt/common/etc/init.d/20extgapps:system/etc/init.d/20extgapps

# Apps2sd files
PRODUCT_COPY_FILES += \
    vendor/ev/prebuilt/common/bin/a2sd:system/bin/a2sd \
    vendor/ev/prebuilt/common/bin/fix_permissions:system/bin/fix_permissions \
    vendor/ev/prebuilt/common/xbin/zipalign:system/xbin/zipalign \
    vendor/ev/prebuilt/common/etc/init.d/10apps2sd-redux:system/etc/init.d/10apps2sd

# Misc files
PRODUCT_COPY_FILES += \
    vendor/ev/prebuilt/common/bin/enable_zram:system/bin/enable_zram
