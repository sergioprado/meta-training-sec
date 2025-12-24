FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = "\
    file://training-sec.conf \
    file://netdiag.html \
    file://dashboard.html \
    file://index.html \
    file://status.html \
    file://login.sh \
    file://status.sh \
    file://device-info.sh \
    file://netdiag.sh \
    file://labworks.png \
"

do_install:append() {
    # configuration
    mkdir -p ${D}/etc/lighttpd.d/
    install -m 644 ${WORKDIR}/training-sec.conf ${D}/etc/lighttpd.d/training-sec.conf

    # web pages
    mkdir -p ${D}/www/pages/
    install -m 644 ${WORKDIR}/netdiag.html ${D}/www/pages/
    install -m 644 ${WORKDIR}/index.html ${D}/www/pages/
    install -m 644 ${WORKDIR}/status.html ${D}/www/pages/
    install -m 644 ${WORKDIR}/dashboard.html ${D}/www/pages/

    # CGI scripts
    mkdir -p ${D}/www/pages/cgi-bin
    install -m 755 ${WORKDIR}/netdiag.sh ${D}/www/pages/cgi-bin/
    install -m 755 ${WORKDIR}/login.sh ${D}/www/pages/cgi-bin/
    install -m 755 ${WORKDIR}/status.sh ${D}/www/pages/cgi-bin/
    install -m 755 ${WORKDIR}/device-info.sh ${D}/www/pages/cgi-bin/

    # images
    mkdir -p ${D}/www/pages/images
    install -m 644 ${WORKDIR}/labworks.png ${D}/www/pages/images/
}
