DESCRIPTION = "Embedded Security Training ramdisk image"
LICENSE = "MIT"

INITRAMFS_SCRIPTS ?= "\
    initramfs-framework-base \
    initramfs-module-udev \
"

PACKAGE_INSTALL = "\
    ${INITRAMFS_SCRIPTS} \
    ${VIRTUAL-RUNTIME_base-utils} \
    base-passwd \
"

# Ensure the initramfs only contains the bare minimum
IMAGE_FEATURES = ""
IMAGE_LINGUAS = ""

# Don't allow the initramfs to contain a kernel, as kernel modules will depend
# on the kernel image.
PACKAGE_EXCLUDE = "kernel-image-*"

IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"
IMAGE_NAME_SUFFIX ?= ""

# additional configuration for booting a signed rootfs image
require ${@ 'training-sec-image-ramdisk-signed.inc' if 'signed' in d.getVar('OVERRIDES').split(':') else ''}

inherit core-image
