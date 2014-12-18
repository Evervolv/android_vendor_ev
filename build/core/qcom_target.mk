# Target-specific configuration

# Populate the qcom hardware variants in the project pathmap.
define qcom-set-path-variant
$(call project-set-path-variant,qcom-$(2),TARGET_QCOM_$(1)_VARIANT,hardware/qcom/$(2))
endef

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)

    TARGET_GLOBAL_CFLAGS += -DQCOM_HARDWARE
    TARGET_GLOBAL_CPPFLAGS += -DQCOM_HARDWARE

    ifneq ($(BOARD_USES_LEGACY_QCOM_DISPLAY),true)
        TARGET_USES_QCOM_BSP := true
        TARGET_GLOBAL_CFLAGS += -DQCOM_BSP
        TARGET_GLOBAL_CPPFLAGS += -DQCOM_BSP
    endif

    TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

    # Enable DirectTrack for legacy targets
    ifneq ($(filter msm7x30 msm8660 msm8960,$(TARGET_BOARD_PLATFORM)),)
    ifeq ($(BOARD_USES_LEGACY_ALSA_AUDIO),true)
        TARGET_GLOBAL_CFLAGS += -DQCOM_DIRECTTRACK
        TARGET_GLOBAL_CPPFLAGS += -DQCOM_DIRECTTRACK
    endif
        ifneq ($(BOARD_USES_LEGACY_QCOM_DISPLAY),true)
            # Enable legacy graphics functions
            TARGET_USES_QCOM_BSP_LEGACY := true
            TARGET_GLOBAL_CFLAGS += -DQCOM_BSP_LEGACY
            TARGET_GLOBAL_CPPFLAGS += -DQCOM_BSP_LEGACY
        endif
    endif

    ifneq ($(filter msm8084,$(TARGET_BOARD_PLATFORM)),)
        #This is for 8084 based platforms
        QCOM_AUDIO_VARIANT := audio-caf/msm8084
        QCOM_DISPLAY_VARIANT := display-caf/msm8084
        QCOM_MEDIA_VARIANT := media-caf/msm8084
    else ifneq ($(filter msm8610 msm8226 msm8974,$(TARGET_BOARD_PLATFORM)),)
        #This is for 8974 based (and B-family) platforms
        QCOM_AUDIO_VARIANT := audio-caf/msm8974
        QCOM_DISPLAY_VARIANT := display-caf/msm8974
        QCOM_MEDIA_VARIANT := media-caf/msm8974
    else
        QCOM_AUDIO_VARIANT := audio-caf/msm8960
        # Enables legacy repos to be handled
        ifeq ($(BOARD_USES_LEGACY_QCOM_DISPLAY),true)
            QCOM_DISPLAY_VARIANT := display-legacy
            QCOM_MEDIA_VARIANT := media-legacy
        else
            QCOM_DISPLAY_VARIANT := display-caf/msm8960
            QCOM_MEDIA_VARIANT := media-caf/msm8960
        endif
    endif

else
    # QSD8K doesn't use QCOM_HARDWARE flag
    ifneq ($(filter qsd8k,$(TARGET_BOARD_PLATFORM)),)
        QCOM_AUDIO_VARIANT := audio-caf/msm8960
    else
        QCOM_AUDIO_VARIANT := audio
    endif
    ifeq ($(BOARD_USES_LEGACY_QCOM_DISPLAY),true)
        QCOM_DISPLAY_VARIANT := display-legacy
        QCOM_MEDIA_VARIANT := media-legacy
    else
        QCOM_DISPLAY_VARIANT := display
        QCOM_MEDIA_VARIANT := media
    endif
endif

$(call project-set-path,qcom-audio,hardware/qcom/$(QCOM_AUDIO_VARIANT))
$(call project-set-path,qcom-display,hardware/qcom/$(QCOM_DISPLAY_VARIANT))
$(call project-set-path,qcom-media,hardware/qcom/$(QCOM_MEDIA_VARIANT))
$(call qcom-set-path-variant,CAMERA,camera)
$(call qcom-set-path-variant,GPS,gps)
$(call qcom-set-path-variant,SENSORS,sensors)
