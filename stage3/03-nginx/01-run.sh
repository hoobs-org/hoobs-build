#!/bin/bash -e

#
# Setup nginx
#

mkdir -p "${ROOTFS_DIR}/usr/share/hoobs"

install -m 644 files/nginx.conf "${ROOTFS_DIR}/etc/nginx/"
install -m 644 files/hoobs.conf "${ROOTFS_DIR}/etc/nginx/conf.d/"
install -m 644 files/loader.html "${ROOTFS_DIR}/usr/share/hoobs/"

on_chroot << EOF
systemctl enable nginx
nginx -t
EOF
