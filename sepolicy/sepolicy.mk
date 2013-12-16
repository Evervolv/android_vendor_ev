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
    installd.te \
    seapp_contexts \
    vold.te \
    mac_permissions.xml
