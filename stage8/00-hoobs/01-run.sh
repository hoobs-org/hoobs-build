#!/bin/bash -e 

install -m 644 files/sudoers "${ROOTFS_DIR}/etc/"
install -m 644 files/console.hoobsd.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/default.hoobsd.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/hoobs-server.tgz "${ROOTFS_DIR}/"

on_chroot << EOF
npm install -g --unsafe-perm /hoobs-server.tgz
npm install -g node-pty

rm -rf /hoobs-core.tgz

systemctl enable console.hoobsd.service
systemctl enable default.hoobsd.service
EOF
