echo "=== Booting from U-Boot boot script ==="

bootm ${fit_addr_r}#conf-qemuarm64.dtb
