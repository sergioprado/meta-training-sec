FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = "\
    file://0001-pflash_cfi01-fix-timeout-issue.patch \
"
