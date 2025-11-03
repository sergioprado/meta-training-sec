INITRAMFS_SCRIPTS:append = "\
    initramfs-module-dmverity \
"

PACKAGE_INSTALL:append = "\
    cryptsetup \
"

# rootfs should be built before the ramdisk so we have to dm-verity.env to add to the ramdisk
do_image[depends] += "${DM_VERITY_IMAGE}:do_image_${DM_VERITY_IMAGE_TYPE}"

# ensure dm-verity.env is updated also when rebuilding DM_VERITY_IMAGE
do_image[nostamp] = "1"

# deploy verity hash into ramdisk image
deploy_verity_hash() {
    install -D -m 0644 \
        ${STAGING_VERITY_DIR}/${DM_VERITY_IMAGE}.${DM_VERITY_IMAGE_TYPE}.verity.env \
        ${IMAGE_ROOTFS}${datadir}/misc/dm-verity.env
}
IMAGE_PREPROCESS_COMMAND += "deploy_verity_hash;"
