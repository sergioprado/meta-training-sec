FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = "\
    file://asan.cfg \
    file://dm-verity.cfg \
    file://dm-integrity.cfg \
    file://fs-verity.cfg \
    file://module-sig.cfg \
    file://audit.cfg \
    file://cgroups.cfg \
    file://devkey.pem \
    file://devkey-cert.pem \
"

do_configure:append() {
    cp ${WORKDIR}/devkey.pem ${S}/certs/devkey.pem
    cat ${WORKDIR}/devkey-cert.pem >> ${S}/certs/devkey.pem

    cp ${WORKDIR}/devkey-cert.pem ${S}/certs/devkey-cert.pem
}

# include any machine specific configuration
include linux-${MACHINE}.inc
