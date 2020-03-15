#!/bin/bash -e 

mkdir -p "${ROOTFS_DIR}/lib64"

install -m 644 "files/ld-linux-aarch64.so.1" "${ROOTFS_DIR}/lib/"
install -m 644 "files/libc.so.6" "${ROOTFS_DIR}/lib64/"
install -m 644 "files/node-install.tar.gz" "${ROOTFS_DIR}/node-install.tar.gz"

on_chroot << EOF
uname -a

set -e
set -x

tar -xzf /node-install.tar.gz -C /usr/local --strip-components=1 --no-same-owner
rm -rf /node-install.tar.gz

node -v
npm -v
EOF
