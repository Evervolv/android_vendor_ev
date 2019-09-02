# Add devices below
supported_devices=(
  'arm'
  'arm64'
  'gt58wifi'
  'guacamole'
  'oneplus3'
  'tenderloin'
  'x86'
  'x86_64'
)

for device in ${supported_devices[@]}; do
    add_lunch_combo ev_${device}-eng
    add_lunch_combo ev_${device}-user
    add_lunch_combo ev_${device}-userdebug
done
