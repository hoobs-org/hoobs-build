#!/bin/bash -e 

install -m 644 files/ffmpeg.tar.gz "${ROOTFS_DIR}/"

on_chroot << EOF
uname -a

set -e
set -x

apt-get update && apt-get install -y libtool-bin libtool openssl libopus-dev libx264-dev libvpx-dev libvorbis-dev libtheora-dev libmp3lame-dev libfreetype6-dev libass-dev libspeex-dev libfontconfig-dev frei0r-plugins-dev libfribidi-dev librubberband-dev libsoxr-dev libvidstab-dev libwebp-dev libxml2-dev libxvidcore-dev

tar -xzf /ffmpeg.tar.gz -C /usr/local --strip-components=1 --no-same-owner
rm -rf /ffmpeg.tar.gz

ldconfig -n /usr/local/lib
ldconfig

ffmpeg -version
EOF
