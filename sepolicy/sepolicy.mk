#
# This policy configuration will be used by all products that
# use SELinux
#

BOARD_SEPOLICY_DIRS += \
    vendor/ev/sepolicy

BOARD_SEPOLICY_UNION += \
    file.te \
    file_contexts \
    fs_use \
    genfs_contexts \
    seapp_contexts \
    installd.te \
    ueventd.te \
    vold.te \
    mac_permissions.xml
