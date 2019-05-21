#!/bin/bash -e

#
# Setup nginx
#

install -m 644 files/default "${ROOTFS_DIR}/etc/nginx/sites-enabled/"
install -m 644 files/custom_502.html "${ROOTFS_DIR}/usr/share/nginx/html/"

on_chroot << EOF
systemctl enable nginx
nginx -t
EOF
