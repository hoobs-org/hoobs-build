#!/bin/bash -e 

#
# Install Homebridge and Homebridge Config UI X
#

#
# Copy service files
#

install -m 644 files/homebridge.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/homebridge-config-ui-x.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/hoobs-arch-check.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/env "${ROOTFS_DIR}/etc/default/homebridge"
install -m 644 files/hoobs-update "${ROOTFS_DIR}/usr/local/sbin/"
install -m 644 files/hoobs-arch-check "${ROOTFS_DIR}/usr/local/sbin/"

install -v -d -o 1000 -g 1000                           "${ROOTFS_DIR}/var/lib/homebridge"
install -v -m 644 -o 1000 -g 1000 files/config.json     "${ROOTFS_DIR}/var/lib/homebridge/"

on_chroot << EOF
# install homebridge and homebridge-config-ui-x
npm install -g --unsafe-perm homebridge homebridge-config-ui-x

# correct ownership
chown -R hoobs:hoobs /var/lib/homebridge
chmod +x /usr/local/sbin/hoobs-update
chmod +x /usr/local/sbin/hoobs-arch-check

# make a symlink to the main config directory
[ -e /home/hoobs/config ] || ln -fs /var/lib/homebridge /home/hoobs/config

# grant hoobs user password-less sudo
echo 'hoobs    ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo

# store the build arch
echo "armv7l" > /etc/hoobs-arch

systemctl daemon-reload
systemctl enable homebridge
systemctl enable homebridge-config-ui-x
systemctl enable hoobs-arch-check
EOF

