#Config used for full targets, with telephony or without.

$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common.mk)

# Optional external packages
PRODUCT_PACKAGES += \
    AndroidTerm

# Optional Evervolv packages
PRODUCT_PACKAGES += \
    EVTips \
    EVWidgets
