FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = "\
    file://history.sh \
"

setup_history() {
    install -d ${D}/${sysconfdir}/profile.d
    install -m 664 ${WORKDIR}/history.sh ${D}/${sysconfdir}/profile.d/history.sh
}
setup_history:signed() {
    echo "Nothing to be done"
}
do_install:append() {
    setup_history
}

FILES:${PN} += "/etc/profile.d"
