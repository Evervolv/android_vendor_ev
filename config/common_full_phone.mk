# Inherit common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common.mk)

# Telephony packages
PRODUCT_PACKAGES += \
    apns-conf.xml \
    sensitive_pn.xml \
    messaging \
    Stk \
    CellBroadcastReceiver

# Default ringtone
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.ringtone=Orion.ogg

# Legacy support
ifneq ($(TARGET_USES_OLD_MNC_FORMAT),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.use_old_mnc_mcc_format=true
endif
