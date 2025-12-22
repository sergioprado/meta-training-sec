FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = "\
    file://netdiag.html \
    file://dashboard.html \
    file://netdiag.sh \
    file://training-sec.conf \
"

do_install:append() {
    mkdir -p ${D}/etc/lighttpd.d/
    install -m 644 ${WORKDIR}/training-sec.conf ${D}/etc/lighttpd.d/training-sec.conf

    mkdir -p ${D}/www/pages/cgi-bin
    install -m 644 ${WORKDIR}/netdiag.html ${D}/www/pages/netdiag.html
    install -m 755 ${WORKDIR}/netdiag.sh ${D}/www/pages/cgi-bin/netdiag.sh

    mkdir -p ${D}/www/pages/dashboard/
    install -m 644 ${WORKDIR}/dashboard.html ${D}/www/pages/dashboard/index.html
}
