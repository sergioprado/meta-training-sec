FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = "\
    file://asan.cfg \
    file://dm-verity.cfg \
"

# include any machine specific configuration
include linux-${MACHINE}.inc
