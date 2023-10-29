# GMS
ifeq ($(WITH_GMS),true)
WITH_GMS_COMMS_SUITE := true
endif

# Telephony packages
PRODUCT_PACKAGES += \
    apns-conf.xml \
    sensitive_pn.xml \
    messaging \
    Stk \
    CellBroadcastReceiver

# Legacy support
ifeq ($(TARGET_USES_OLD_MNC_FORMAT), true)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.use_old_mnc_mcc_format=true
endif
