# Boot animation
BOOT_ANIMATION_SIZE ?= 1080p
ifeq ($(BOOT_ANIMATION_SIZE),1440p)
TARGET_SCREEN_HEIGHT := 3120
TARGET_SCREEN_WIDTH := 1440
else ifeq ($(BOOT_ANIMATION_SIZE),1080p)
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080
else ifeq ($(BOOT_ANIMATION_SIZE),720p)
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080
endif

# AOSP has no support of loading framework resources from /system_ext
# so the SDK has to stay in /system for now
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/etc/permissions/com.evervolv.platform.xml \
    system/framework/oat/%/com.evervolv.platform.odex \
    system/framework/oat/%/com.evervolv.platform.vdex \
    system/framework/com.evervolv.platform-res.apk \
    system/framework/com.evervolv.platform.jar

PRODUCT_PACKAGES += \
    bootanimation.zip \
    com.evervolv.platform-res \
    com.evervolv.platform \
    EVSettingsProvider \
    EVToolbox \
    EVUpdater
