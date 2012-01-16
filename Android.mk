# We need a way to prevent the stuff Google Apps replaces from being included in the build.
# This is a hacky way to do that.
ifeq ($(GAPPS),true)
    PACKAGES.Email.OVERRIDES := Provision QuickSearchBox Calendar CalendarProvider libspeexresampler
endif
