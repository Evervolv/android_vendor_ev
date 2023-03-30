# Inherit common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common.mk)

# AOSP packages
PRODUCT_PACKAGES += \
    LeanbackIME

# Permissions
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=log
