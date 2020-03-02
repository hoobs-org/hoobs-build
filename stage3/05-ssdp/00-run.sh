#!/bin/bash -e

#
# Add SSDP Service - this allows the device to be discoverable in Windows
#

install -m 644 files/ssdpd.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/ssdp-responder-v1.6.1-linux-arm.tar.gz "${ROOTFS_DIR}/"

on_chroot << EOF
wget -O /etc/ssl/certs/cacert.pem https://curl.haxx.se/ca/cacert.pem

echo 'SSL_CERT_FILE=/etc/ssl/certs/cacert.pem' | sudo tee -a /etc/environment

tar -xzf /ssdp-responder-v1.6.1-linux-arm.tar.gz -C / --no-same-owner
rm -rf /ssdp-responder-v1.6.1-linux-arm.tar.gz

systemctl daemon-reload
systemctl enable ssdpd
EOF
