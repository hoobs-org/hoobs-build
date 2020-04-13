#!/bin/bash -e 

install -m 644 files/sudoers "${ROOTFS_DIR}/etc/"
install -m 644 files/console.hoobsd.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/default.hoobsd.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/hoobs-server.tgz "${ROOTFS_DIR}/"

on_chroot << EOF
npm_config_user=root npm install -g --unsafe-perm /hoobs-server.tgz
npm_config_user=root npm install -g --unsafe-perm node-pty

rm -rf /hoobs-core.tgz

systemctl enable console.hoobsd.service
systemctl enable default.hoobsd.service
EOF
