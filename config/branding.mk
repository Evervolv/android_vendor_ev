# Check BOOT_ANIMATION_SIZE for a valid size
ifneq ($(filter 720p 1080p 1440p hvga qhd wvga xga,$(BOOT_ANIMATION_SIZE)),)
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/bootanimation/$(BOOT_ANIMATION_SIZE).zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip
else
$(warning ************************************************************)
$(warning BOOT_ANIMATION_SIZE is either null or invalid.)
$(warning Choices are 720p, 1080p, 1440p, hvga, qhd, wvga, and xga.)
$(warning Please update your device tree to a valid choice.)
$(warning Otherwise, no animation will be present.)
$(warning ************************************************************)
endif

# Build type
PRODUCT_BUILD := userbuild
ifeq ($(NIGHTLY_BUILD),true)
PRODUCT_BUILD := nightly
else ifeq ($(TESTING_BUILD),true)
PRODUCT_BUILD := testing
endif

PRODUCT_MOTD ?="\n\n\n--------------------MESSAGE---------------------\nThank you for choosing Evervolv\nPlease visit us at \#evervolv on irc.freenode.net\nFollow @preludedrew for the latest Evervolv updates\nGet the latest rom at evervolv.com\n------------------------------------------------\n"

# SDK
ifndef EV_PLATFORM_SDK_VERSION
  # This is the canonical definition of the SDK version, which defines
  # the set of APIs and functionality available in the platform.  It
  # is a single integer that increases monotonically as updates to
  # the SDK are released.  It should only be incremented when the APIs for
  # the new release are frozen (so that developers don't write apps against
  # intermediate builds).
  EV_PLATFORM_SDK_VERSION := 2
endif

ifndef EV_PLATFORM_REV
  # For internal SDK revisions that are hotfixed/patched
  # Reset after each EV_PLATFORM_SDK_VERSION release
  # If you are doing a release and this is NOT 0, you are almost certainly doing it wrong
  EV_PLATFORM_REV := 0
endif

PRODUCT_PACKAGES += \
    com.evervolv.hardware.xml \
    com.evervolv.performance.xml \
    com.evervolv.platform-res \
    com.evervolv.platform \
    com.evervolv.platform.xml \
    EVSettingsProvider

ifeq ($(shell test $(PLATFORM_SDK_VERSION) -lt 29; echo $$?),0)
PRODUCT_PACKAGES += \
    com.evervolv.style.xml
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.evervolv.build.version.plat.sdk=$(EV_PLATFORM_SDK_VERSION) \
    ro.evervolv.build.version.plat.rev=$(EV_PLATFORM_REV)

# Toolbox
PRODUCT_PACKAGES += \
    EVToolbox

# Updater
ifneq ($(filter nightly testing,$(PRODUCT_BUILD)),)
PRODUCT_PACKAGES += \
    EVUpdater
endif

# Version Info
PRODUCT_VERSION_MAJOR = 11
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 0

ifeq ($(PRODUCT_VERSION),)
PRODUCT_VERSION := $(PRODUCT_VERSION_MAJOR)
ifneq ($(PRODUCT_VERSION_MINOR),0)
PRODUCT_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)
ifneq ($(PRODUCT_VERSION_MINOR),0)
PRODUCT_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)
endif
endif
endif

ifeq ($(PRODUCT_CODENAME),)
PRODUCT_CODENAME := $(TARGET_DEVICE)
endif

ROM_VERSION := $(TARGET_PRODUCT)-$(PRODUCT_VERSION)-$(PRODUCT_BUILD)-$(shell date +%Y.%m.%d)
TARGET_OTA_PACKAGE_NAME := $(shell echo ${ROM_VERSION} | tr [:upper:] [:lower:])

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.evervolv.display.version=$(PRODUCT_VERSION) \
    ro.evervolv.device=$(PRODUCT_CODENAME) \
    ro.evervolv.version=$(TARGET_OTA_PACKAGE_NAME)
