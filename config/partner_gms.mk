# Client ID
ifeq ($(PRODUCT_IS_ATV),true)
ifeq ($(PRODUCT_ATV_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.oem.key1=ATV00100020
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.oem.key1=$(PRODUCT_ATV_CLIENTID_BASE)
endif
endif

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# GMS
ifeq ($(WITH_GMS),true)
    ifeq ($(PRODUCT_IS_ATV),true)
        GMS_PATH := vendor/partner_gms-tv
    else ifeq ($(PRODUCT_IS_AUTO),true)
        GMS_PATH := vendor/partner_gms-car
    else
        GMS_PATH := vendor/partner_gms
    endif

    # Dexpreopt
    # Don't dexpreopt prebuilts. (For GMS).
    DONT_DEXPREOPT_PREBUILTS := true

    # Specify the GMS makefile you want to use, for example:
    #   - fi.mk             - Project Fi
    #   - gms.mk            - default GMS
    #   - gms_gtv.mk        - default GMS (TV)
    #   - gms_go.mk         - low ram devices
    #   - gms_go_2gb.mk     - low ram devices (2GB)
    #   - gms_64bit_only.mk - devices supporting 64-bit only
    #   - gms_minimal.mk    - minimal GMS
    GMS_MAKEFILE ?= gms.mk

    ifeq ($(PRODUCT_IS_ATV),true)
        MAINLINE_MODULES_PATH ?= $(GMS_PATH)
    else
        MAINLINE_MODULES_PATH ?= vendor/partner_modules
    endif

    # Specify the mainline module makefile you want to use, for example:
    #   - mainline_modules.mk              - updatable apex
    #   - mainline_modules_flatten_apex.mk - flatten apex (Not available for TV)
    #   - mainline_modules_low_ram.mk      - low ram devices (Not available for TV)
    ifeq ($(TARGET_FLATTEN_APEX), true)
        MAINLINE_MODULES_MAKEFILE ?= mainline_modules_flatten_apex.mk
    else
        MAINLINE_MODULES_MAKEFILE ?= mainline_modules.mk
    endif

    $(call inherit-product, $(GMS_PATH)/products/$(GMS_MAKEFILE))

    # Special handling for Android TV
    ifeq ($(PRODUCT_IS_ATV),true)
        $(call inherit-product-if-exists, $(MAINLINE_MODULES_PATH)/products/$(MAINLINE_MODULES_MAKEFILE))
    else
        $(call inherit-product-if-exists, $(MAINLINE_MODULES_PATH)/build/$(MAINLINE_MODULES_MAKEFILE))
    endif
endif
