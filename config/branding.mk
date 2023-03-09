# Boot animation
BOOT_ANIMATION_SIZE ?= 1080p
ifneq ($(filter 720p 1080p 1440p hvga qhd wvga xga,$(BOOT_ANIMATION_SIZE)),)
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/bootanimation/$(BOOT_ANIMATION_SIZE).zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/media/bootanimation.zip
endif

# AOSP has no support of loading framework resources from /system_ext
# so the SDK has to stay in /system for now
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/etc/permissions/com.evervolv.globalactions.xml \
    system/etc/permissions/com.evervolv.hardware.xml \
    system/etc/permissions/com.evervolv.livedisplay.xml \
    system/etc/permissions/com.evervolv.platform.xml \
    system/framework/oat/%/com.evervolv.platform.odex \
    system/framework/oat/%/com.evervolv.platform.vdex \
    system/framework/com.evervolv.platform-res.apk \
    system/framework/com.evervolv.platform.jar

PRODUCT_PACKAGES += \
    com.evervolv.globalactions.xml \
    com.evervolv.hardware.xml \
    com.evervolv.livedisplay.xml \
    com.evervolv.platform-res \
    com.evervolv.platform \
    com.evervolv.platform.xml \
    EVSettingsProvider \
    EVToolbox \
    EVUpdater
