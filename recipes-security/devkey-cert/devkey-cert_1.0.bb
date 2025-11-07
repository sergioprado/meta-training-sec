SUMMARY = "Install development key certificate"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch

SRC_URI = "\
    file://devkey-cert.der \
    file://devkey-cert.pem \
"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/certificates
    install -m 0644 ${WORKDIR}/devkey-cert.der ${D}${sysconfdir}/certificates/devkey-cert.der
    install -m 0644 ${WORKDIR}/devkey-cert.pem ${D}${sysconfdir}/certificates/devkey-cert.pem
}
