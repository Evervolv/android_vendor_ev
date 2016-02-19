# Inherit common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common.mk)

# World APN list
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# SIM Toolkit
PRODUCT_PACKAGES += \
    Stk
