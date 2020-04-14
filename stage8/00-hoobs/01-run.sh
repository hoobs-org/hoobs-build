#!/bin/bash -e 

install -m 644 files/sudoers "${ROOTFS_DIR}/etc/"
install -m 644 files/hoobs-server.tgz "${ROOTFS_DIR}/"

on_chroot << EOF
npm_config_user=root npm install -g --unsafe-perm /hoobs-server.tgz

rm -rf /hoobs-core.tgz

hoobs enable cockpit

hoobs instance remove -i default
hoobs instance remove -i console
hoobs instance create -i Default -s 51825 -b 51826
EOF
