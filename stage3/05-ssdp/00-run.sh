#!/bin/bash -e

#
# Add SSDP Service - this allows the device to be discoverable in Windows
#

install -m 644 files/ssdpd.service "${ROOTFS_DIR}/etc/systemd/system/"

export SSDP_VERSION=v1.6.1
export SSDP_RELEASE_URL=https://github.com/hoobs-org/ssdp-responder/releases/download/$SSDP_VERSION/ssdp-responder-$SSDP_VERSION-linux-arm.tar.gz

on_chroot << EOF
echo $SSDP_RELEASE_URL

curl -fLO $SSDP_RELEASE_URL
tar -xzf ssdp-responder-$SSDP_VERSION-linux-arm.tar.gz -C / --no-same-owner
rm -rf ssdp-responder-$SSDP_VERSION-linux-arm.tar.gz

systemctl daemon-reload
systemctl enable ssdpd
EOF
