SRC_URI:append = "\
    file://qemuarm64-custom.cfg \
"

do_compile:append:signed() {
    cp ${B}/dts/dt.dtb ${B}/u-boot.dtb
}
