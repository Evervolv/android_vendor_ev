function __print_ev_functions_help() {
cat <<EOF
Additional Evervolv functions:
EOF

function find_deps() {

    if [ -z "$TARGET_PRODUCT" ]
    then
        echo "TARGET_PRODUCT not set..."
        lunch
    fi

    vendor/ev/build/tools/roomservice.py $TARGET_PRODUCT true
    if [ $? -ne 0 ]
    then
        echo "find_deps failed."
    fi
}

function breakfast()
{
    target=$1
    EV_DEVICES_ONLY="true"
    unset LUNCH_MENU_CHOICES
    add_lunch_combo full-eng
    for f in `/bin/ls vendor/ev/vendorsetup.sh 2> /dev/null`
        do
            echo "including $f"
            . $f
        done
    unset f

    if [ $# -eq 0 ]; then
        # No arguments, so let's have the full menu
        echo "Nothing to eat for breakfast?"
        lunch
    else
        echo "z$target" | grep -q "-"
        if [ $? -eq 0 ]; then
            # A buildtype was specified, assume a full device name
            lunch $target
        else
            # This is probably just the EV model name
            lunch ev_$target-eng
        fi
    fi
    return $?
}
