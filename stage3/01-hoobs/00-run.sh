#!/bin/bash -e 

install -m 644 files/hoobs.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/hoobs-core.tgz "${ROOTFS_DIR}/"

on_chroot << EOF
# install hoobs-core
npm install -g --unsafe-perm /hoobs-core.tgz
rm -rf /hoobs-core.tgz

# grant hoobs user password-less sudo
echo 'hoobs    ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo

systemctl daemon-reload
systemctl enable hoobs
EOF
