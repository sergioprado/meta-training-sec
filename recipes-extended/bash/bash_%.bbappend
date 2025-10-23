FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = "\
    file://history.sh \
"

do_install:append() {
    install -d ${D}/${sysconfdir}/profile.d
    install -m 664 ${WORKDIR}/history.sh ${D}/${sysconfdir}/profile.d/history.sh
}

FILES:${PN} += "/etc/profile.d"
