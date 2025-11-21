SUMMARY = "Initialization commands for the Embedded Security training"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://training-sec-init.sh \
    file://training-sec \
"

S = "${WORKDIR}"

inherit update-rc.d

INITSCRIPT_NAME = "training-sec"
INITSCRIPT_PARAMS = "defaults 99"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/training-sec-init.sh ${D}${bindir}/training-sec-init.sh

    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/training-sec ${D}${sysconfdir}/init.d/training-sec
}
