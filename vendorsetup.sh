# Add devices below
supported_devices=(
  'flo'
  'gt58wifi'
  'hammerhead'
  'oneplus3'
  'shamu'
  'tenderloin'
)

for device in ${supported_devices[@]}; do
    add_lunch_combo ev_${device}-userdebug
done
