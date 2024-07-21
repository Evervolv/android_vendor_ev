# Inherit mobile full common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common_mobile_full.mk)

# Inherit tablet common stuff
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/tablet.mk)

$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/telephony.mk)
