#!/bin/bash -e 

install -m 644 files/ffmpeg.tar.gz "${ROOTFS_DIR}/"

on_chroot << EOF
uname -a

set -e
set -x

apt-get update && apt-get install -y libx264-dev

tar -xzf /ffmpeg.tar.gz -C /usr/local --strip-components=1 --no-same-owner
rm -rf /ffmpeg.tar.gz

ldconfig

ffmpeg -version
EOF
