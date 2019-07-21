# Add devices below
supported_devices=(
  'gt58wifi'
  'guacamole'
  'oneplus3'
  'tenderloin'
)

for device in ${supported_devices[@]}; do
    add_lunch_combo ev_${device}-eng
    add_lunch_combo ev_${device}-user
    add_lunch_combo ev_${device}-userdebug
done
