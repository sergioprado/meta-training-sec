FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = "\
    file://ssh_host_ecdsa_key \
    file://ssh_host_ecdsa_key.pub \
    file://ssh_host_ed25519_key \
    file://ssh_host_ed25519_key.pub \
    file://ssh_host_rsa_key \
    file://ssh_host_rsa_key.pub \
"

# install pre-generated SSH keys - this is mainly to avoid
# regenerating the keys everytime the image is rebuilt, since
# it takes time and causes the ssh client to complain with:
#   "WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!"
do_install:append() {
    install -d ${D}${sysconfdir}/ssh/
    install -m 600 ${WORKDIR}/ssh_host_ecdsa_key ${D}${sysconfdir}/ssh/
    install -m 600 ${WORKDIR}/ssh_host_ed25519_key ${D}${sysconfdir}/ssh/
    install -m 600 ${WORKDIR}/ssh_host_rsa_key ${D}${sysconfdir}/ssh/
    install -m 644 ${WORKDIR}/ssh_host_ecdsa_key.pub ${D}${sysconfdir}/ssh/
    install -m 644 ${WORKDIR}/ssh_host_ed25519_key.pub ${D}${sysconfdir}/ssh/
    install -m 644 ${WORKDIR}/ssh_host_rsa_key.pub ${D}${sysconfdir}/ssh/
}
