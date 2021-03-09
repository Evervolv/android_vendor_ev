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

# Bootanimation
TARGET_SCREEN_WIDTH ?= 1080
TARGET_SCREEN_HEIGHT ?= 1920
