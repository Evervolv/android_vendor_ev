#Config used for full targets, with telephony or without.

# Bring in all audio files
include frameworks/base/data/sounds/AllAudio.mk

#include vendor/ev/config/themes.mk

ifeq ($(TARGET_USE_KEYBOARD), international)
    PRODUCT_PACKAGE_OVERLAYS += vendor/ev/overlay/full
endif

PRODUCT_PACKAGES += \
    VideoEditor \
    VoiceDialer \
    Basic \
    HoloSpiralWallpaper \
    MagicSmokeWallpapers \
    NoiseField \
    Galaxy4 \
    LiveWallpapers \
    LiveWallpapersPicker \
    VisualizationWallpapers \
    PhaseBeam
