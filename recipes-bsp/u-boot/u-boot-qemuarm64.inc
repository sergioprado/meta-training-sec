SRC_URI:append = "\
    file://qemuarm64-custom.cfg \
    file://boot.cmd \
    file://fw_env.config \
"

# provide the empty flash image to persist the bootloader environment
UBOOT_BOOTENV_FILE = "bootenv.img"

do_compile:append:signed() {
    cp ${B}/dts/dt.dtb ${B}/u-boot.dtb
}

do_deploy:append (){
    # note: the flash size is predefined by QEMU
    qemu-img create -f raw ${UBOOT_BOOTENV_FILE} 64M
}

do_deploy[depends] += "qemu-system-native:do_populate_sysroot"
