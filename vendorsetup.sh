# Add devices below
supported_devices=(
  'flo'
  'hammerhead'
  'oneplus3'
)

for device in ${supported_devices[@]}; do
    add_lunch_combo ev_${device}-userdebug
done
