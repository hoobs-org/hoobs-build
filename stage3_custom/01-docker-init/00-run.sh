#!/bin/bash -e 

#
# Pull the docker image using the host system them copy to the image fs
#

docker pull oznu/homebridge:debian-raspberry-pi

install -d "${ROOTFS_DIR}/var/lib/docker/image"
cp -R /var/lib/docker/image/overlay2 "${ROOTFS_DIR}/var/lib/docker/image"
cp -R /var/lib/docker/overlay2 "${ROOTFS_DIR}/var/lib/docker"

#
# Copy service files
#

install -m 644 files/homebridge.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/start.sh "${ROOTFS_DIR}/home/hoobs/"
install -m 644 files/docker-compose.yml "${ROOTFS_DIR}/home/hoobs/"
install -m 644 files/update "${ROOTFS_DIR}/etc/cron.daily/homebridge"

on_chroot << EOF
chmod +x /home/hoobs/start.sh
chmod +x /etc/cron.daily/homebridge
chown -R hoobs:hoobs /home/hoobs

systemctl daemon-reload
systemctl enable homebridge
EOF

