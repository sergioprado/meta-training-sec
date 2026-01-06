FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = "\
    file://0001-tpm2_hash-add-crash-logic.patch \
"
