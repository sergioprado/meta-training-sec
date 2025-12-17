SUMMARY = "Reference image for the Embedded security training"

LICENSE = "MIT"

IMAGE_INSTALL_DEBUG_TOOLS = "\
    gdb \
    checksec \
    strace \
    ltrace \
    kernel-hardening-checker \
    fio \
"

IMAGE_INSTALL_SCAN_TOOLS = "\
    lynis \
"

IMAGE_INSTALL_NETWORK_TOOLS = "\
    openssh \
    lighttpd \
    lighttpd-module-cgi \
    netcat \
    curl \
    wireguard-tools \
    nftables \
"

IMAGE_INSTALL_SANITIZERS = "\
    libasan \
    libubsan \
    liblsan \
    libtsan \
"

IMAGE_INSTALL_FS_TOOLS = "\
    e2fsprogs-mke2fs \
    e2fsprogs-tune2fs \
    e2fsprogs \
    attr \
    acl \
"

IMAGE_INSTALL_CRYPTO_TOOLS = "\
    cryptsetup \
    fscryptctl \
    keyutils \
    tpm2-tools \
    libtss2-tcti-device \
    cryptsetup \
    fsverity-utils \
"

IMAGE_INSTALL_AUTH_UTILS = "\
    libpam \
    pam-plugin-faillock \
    google-authenticator-libpam \
    pam-google-authenticator \
    libpwquality \
"

IMAGE_INSTALL_SANDBOX_TOOLS = "\
    bubblewrap \
"
IMAGE_INSTALL_SANDBOX_TOOLS:docker += "\
    docker \
"

IMAGE_INSTALL_OPTEE = "\
    optee-os-ta \
    optee-client \
    optee-ftpm \
    optee-test \
    optee-examples \
"

IMAGE_INSTALL_SELINUX = "\
    packagegroup-core-selinux \
"

IMAGE_INSTALL_TRAINING = "\
    training-sec-init \
    devkey-cert \
"

IMAGE_INSTALL_EDITORS = "\
    vim-xxd \
"

IMAGE_INSTALL_UTILS = "\
    bash \
    util-linux \
    coreutils \
    expect \
    libcap-bin \
    auditd \
"

IMAGE_INSTALL_KERNEL = "\
    kernel-modules \
"

IMAGE_INSTALL = "\
    packagegroup-core-boot \
    ${CORE_IMAGE_EXTRA_INSTALL} \
    ${IMAGE_INSTALL_SANITIZERS} \
    ${IMAGE_INSTALL_DEBUG_TOOLS} \
    ${IMAGE_INSTALL_SCAN_TOOLS} \
    ${IMAGE_INSTALL_NETWORK_TOOLS} \
    ${IMAGE_INSTALL_FS_TOOLS} \
    ${IMAGE_INSTALL_CRYPTO_TOOLS} \
    ${IMAGE_INSTALL_AUTH_UTILS} \
    ${IMAGE_INSTALL_SANDBOX_TOOLS} \
    ${IMAGE_INSTALL_OPTEE} \
    ${IMAGE_INSTALL_TRAINING} \
    ${IMAGE_INSTALL_EDITORS} \
    ${IMAGE_INSTALL_UTILS} \
    ${IMAGE_INSTALL_KERNEL} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', '${IMAGE_INSTALL_SELINUX}', '', d)} \
"

TOOLCHAIN_TARGET_TASK:append = "\
    kernel-devsrc \
"

TOOLCHAIN_HOST_TASK:append = "\
    nativesdk-python3-cryptography \
"

# additional configuration for booting a signed rootfs image
require ${@ 'training-sec-image-signed.inc' if 'signed' in d.getVar('OVERRIDES').split(':') else ''}

# extra space needed when building with Docker
IMAGE_ROOTFS_EXTRA_SPACE:docker = "262144"

inherit core-image

# create additional users
# admin password is admin1234
inherit extrausers
EXTRA_USERS_PARAMS = "\
    useradd -p '\$5\$E5EBd5883/YCbeoG\$Y4htCJOL9kbxv7y1ry.wjA/sCM6PohASz8C2U4cbzxD' admin; \
    useradd user1; \
    useradd user2; \
    useradd protouser; \
    groupadd protouser; \
"

create_custom_dirs() {
    install -d ${IMAGE_ROOTFS}/apps
    install -d ${IMAGE_ROOTFS}/config
    install -d ${IMAGE_ROOTFS}/data
}
IMAGE_PREPROCESS_COMMAND += "create_custom_dirs;"
