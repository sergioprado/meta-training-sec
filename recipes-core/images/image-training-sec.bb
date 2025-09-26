SUMMARY = "Reference image for the Embedded security training"

LICENSE = "MIT"

IMAGE_INSTALL = "\
    packagegroup-core-boot \
    ${CORE_IMAGE_EXTRA_INSTALL} \
"

inherit core-image
