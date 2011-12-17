# Evervolv
PRODUCT_BRAND ?= evervolv

# Check BOOT_ANIMATION_SIZE for a valid size
ifneq ($(filter 720p 1080p 1440p hvga qhd wvga xga,$(BOOT_ANIMATION_SIZE)),)
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/bootanimation/$(BOOT_ANIMATION_SIZE).zip:system/media/bootanimation.zip
else
$(warning ************************************************************)
$(warning BOOT_ANIMATION_SIZE is either null or invalid.)
$(warning Choices are 720p, 1080p, 1440p, hvga, qhd, wvga, and xga.)
$(warning Please update your device tree to a valid choice.)
$(warning Otherwise, no animation will be present.)
$(warning ************************************************************)
endif

# Version Info
ifneq ($(APPEND_ZIP_VERSION),)
APPEND_ZIP=-$(APPEND_ZIP_VERSION)
endif

ifeq ($(NIGHTLY_BUILD),true)
  ROM_VERSION := $(TARGET_PRODUCT)-$(PLATFORM_VERSION)-nightly-$(shell date +%Y.%m.%d)$(APPEND_ZIP)
else ifeq ($(TESTING_BUILD),true)
  ROM_VERSION := $(TARGET_PRODUCT)-$(PLATFORM_VERSION)-testing-$(shell date +%Y.%m.%d)$(APPEND_ZIP)
else
  ROM_VERSION := $(TARGET_PRODUCT)-$(PLATFORM_VERSION)-userbuild-$(shell date +%Y.%m.%d)$(APPEND_ZIP)
endif

ROM_VERSION := $(shell echo ${ROM_VERSION} | tr [:upper:] [:lower:])

PRODUCT_PROPERTY_OVERRIDES += \
    ro.evervolv.device=$(PRODUCT_CODENAME) \
    ro.evervolv.version=$(ROM_VERSION)
