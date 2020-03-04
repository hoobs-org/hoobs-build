#!/bin/bash -e

install -m 644 files/tzupdate.service "${ROOTFS_DIR}/etc/systemd/system/"

on_chroot << EOF
sudo pip install tzupdate

systemctl daemon-reload
systemctl enable tzupdate
EOF
