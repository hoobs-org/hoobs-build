#!/bin/bash -e 


#
# Install Node.js
# Installing the arm32v6 version of Node to ensure compilability with RaspberryPi 1 / Zero
#

export LTS="$(curl -s https://nodejs.org/dist/index.json | jq -r 'map(select(.lts))[0].version')"

on_chroot << EOF
uname -a

echo "Installing Node.js $LTS..."

set -e
set -x

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
nvm install --lts

node -v
npm -v
EOF
