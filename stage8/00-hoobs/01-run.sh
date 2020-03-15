#!/bin/bash -e 

install -m 644 files/sudoers "${ROOTFS_DIR}/etc/"
install -m 644 files/hoobs.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/hoobs-core.tgz "${ROOTFS_DIR}/"

on_chroot << EOF
npm uninstall -g @hoobs/hoobs
npm install -g --unsafe-perm /hoobs-core.tgz

rm -rf /hoobs-core.tgz

systemctl daemon-reload
systemctl enable hoobs
EOF
