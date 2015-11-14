# Browser
PRODUCT_PACKAGES += \
    Jelly

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    htop \
    mke2fs \
    nano \
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

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni
