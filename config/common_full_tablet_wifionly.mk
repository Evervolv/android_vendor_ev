# Inherit mobile full common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common_mobile_full.mk)

# Inherit full tablet common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/full_tablet.mk)

$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/wifionly.mk)
