#!/bin/bash -e 

install -m 644 files/hoobs.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/hoobs-core.tgz "${ROOTFS_DIR}/"

on_chroot << EOF
npm uninstall -g @hoobs/hoobs
npm install -g --unsafe-perm /hoobs-core.tgz

rm -rf /hoobs-core.tgz

systemctl daemon-reload
systemctl enable hoobs

truncate -s 0 /etc/sudoers

echo '# /etc/sudoers' | tee -a /etc/sudoers
echo '# See the sudoers man page for the details on how to write a sudoers file.' | tee -a /etc/sudoers
echo '' | tee -a /etc/sudoers
echo '# Override built-in defaults' | tee -a /etc/sudoers
echo 'Defaults    env_reset' | tee -a /etc/sudoers
echo 'Defaults    mail_badpass' | tee -a /etc/sudoers
echo 'Defaults    secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"' | tee -a /etc/sudoers
echo 'Defaults    env_keep += "SSL_CERT_FILE"' | tee -a /etc/sudoers
echo '' | tee -a /etc/sudoers
echo '# root and users in the sudo group can run anything as any user' | tee -a /etc/sudoers
echo 'root        ALL=(ALL:ALL) ALL' | tee -a /etc/sudoers
echo '%sudo       ALL=(ALL:ALL) NOPASSWD: ALL' | tee -a /etc/sudoers
EOF
