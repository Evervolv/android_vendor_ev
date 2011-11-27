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
