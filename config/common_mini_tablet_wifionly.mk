# Inherit mobile mini common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common_mobile_mini.mk)

# Inherit tablet common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/tablet.mk)

$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/wifionly.mk)
