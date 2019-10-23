#!/bin/bash -e 

on_chroot << EOF
uname -a

echo "Installing Node.js"

set -e
set -x

curl -kfLO https://nodejs.org/dist/latest-v10.x/node-v10.17.0-linux-armv7l.tar.gz
tar -xzf node-v10.16.3-linux-armv7l.tar.gz -C /usr/local --strip-components=1 --no-same-owner
rm -rf node-v10.16.3-linux-armv7l.tar.gz

curl -ksS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
apt-get update && apt-get install -y yarn

node -v
npm -v
yarn -v
EOF
