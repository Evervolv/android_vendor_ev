# SIM Tool Kit
PRODUCT_PACKAGES += \
    Stk

# World APN list
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

