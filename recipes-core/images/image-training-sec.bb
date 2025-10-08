SUMMARY = "Reference image for the Embedded security training"

LICENSE = "MIT"

IMAGE_INSTALL_SANITIZERS = "\
    libasan \
    libubsan \
    liblsan \
    libtsan \
"

IMAGE_INSTALL = "\
    packagegroup-core-boot \
    ${CORE_IMAGE_EXTRA_INSTALL} \
    ${IMAGE_INSTALL_SANITIZERS} \
    bash \
    openssh \
    gdb \
"

inherit core-image

inherit extrausers
EXTRA_USERS_PARAMS = "\
    useradd -p '\$5\$E5EBd5883/YCbeoG\$Y4htCJOL9kbxv7y1ry.wjA/sCM6PohASz8C2U4cbzxD' admin; \
"
