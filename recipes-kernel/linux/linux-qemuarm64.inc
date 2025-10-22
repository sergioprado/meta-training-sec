SRC_URI:append = "\
    file://qemuarm64.dtsi \
    file://qemuarm64.dts \
"

do_configure:append() {
    cp ${WORKDIR}/qemuarm64.dts* ${S}/arch/arm64/boot/dts/arm/
}
