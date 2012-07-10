#Config used for full targets, with telephony or without.

# Bring in all audio files
include frameworks/base/data/sounds/AllAudio.mk

#include vendor/ev/config/themes.mk

#PRODUCT_PACKAGE_OVERLAYS += vendor/ev/overlay/full

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
