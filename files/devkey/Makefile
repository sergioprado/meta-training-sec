all:
	$(PWD)/../../scripts/gen-devkeys

install:
	cp -v devkey-cert.der devkey-cert.pem ../../recipes-security/devkey-cert/files/
	cp -v devkey-cert.pem devkey.pem ../../recipes-kernel/linux/files/

clean:
	rm -rf devkey-cert.der devkey-cert.pem devkey.pem
