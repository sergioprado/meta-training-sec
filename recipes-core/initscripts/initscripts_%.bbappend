pkg_postinst:${PN} () {
    grep -q "randomize_va_space" $D${sysconfdir}/sysctl.conf || echo kernel.randomize_va_space=0 >> $D${sysconfdir}/sysctl.conf
}
