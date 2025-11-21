#!/bin/sh

# set nameserver
NAMESERVER="nameserver 8.8.8.8"
RESOLVCONF="/etc/resolv.conf"
touch ${RESOLVCONF}
grep -q "^${NAMESERVER}$" ${RESOLVCONF} || echo "${NAMESERVER}" >> ${RESOLVCONF}
