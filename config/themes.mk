# T-Mobile theme engine
PRODUCT_PACKAGES += \
   ThemeChooser \
   ThemeProvider

PRODUCT_COPY_FILES += \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/permissions/com.tmobile.software.themes.xml:system/etc/permissions/com.tmobile.software.themes.xml \
    $(SRC_EVERVOLV_DIR)/prebuilt/common/etc/permissions/org.cyanogenmod.theme.xml:system/etc/permissions/org.cyanogenmod.theme.xml \
