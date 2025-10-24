SUMMARY = "Reference image for the Embedded security training"

LICENSE = "MIT"

IMAGE_INSTALL_DEBUGTOOLS = "\
    gdb \
    checksec \
    kernel-hardening-checker \
"

IMAGE_INSTALL_SANITIZERS = "\
    libasan \
    libubsan \
    liblsan \
    libtsan \
"

IMAGE_INSTALL_DISKTOOLS = "\
    e2fsprogs-mke2fs \
    e2fsprogs-tune2fs \
    e2fsprogs \
"

IMAGE_INSTALL_CRYPTOTOOLS = "\
    cryptsetup \
    fscryptctl \
    keyutils \
    tpm2-tools \
    libtss2-tcti-device \
"

IMAGE_INSTALL_OPTEE = "\
    optee-client \
    optee-ftpm \
    optee-test \
    optee-examples \
"

IMAGE_INSTALL = "\
    packagegroup-core-boot \
    ${CORE_IMAGE_EXTRA_INSTALL} \
    ${IMAGE_INSTALL_SANITIZERS} \
    ${IMAGE_INSTALL_DEBUGTOOLS} \
    ${IMAGE_INSTALL_DISKTOOLS} \
    ${IMAGE_INSTALL_CRYPTOTOOLS} \
    ${IMAGE_INSTALL_OPTEE} \
    bash \
    util-linux \
    openssh \
"

inherit core-image

inherit extrausers
EXTRA_USERS_PARAMS = "\
    useradd -p '\$5\$E5EBd5883/YCbeoG\$Y4htCJOL9kbxv7y1ry.wjA/sCM6PohASz8C2U4cbzxD' admin; \
"

create_data_dir() {
    install -d ${IMAGE_ROOTFS}/data
}
IMAGE_PREPROCESS_COMMAND += "create_data_dir;"
