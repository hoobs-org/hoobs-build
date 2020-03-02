#!/bin/bash -e 

install -m 644 "files/node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.gz" "${ROOTFS_DIR}/node-install.tar.gz"

on_chroot << EOF
uname -a

set -e
set -x

tar -xzf /node-install.tar.gz -C /usr/local --strip-components=1 --no-same-owner
rm -rf /node-install.tar.gz

curl -ksS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

apt-get update && apt-get install -y yarn

node -v
npm -v
yarn -v
EOF
