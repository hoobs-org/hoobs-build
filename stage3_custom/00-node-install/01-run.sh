#!/bin/bash -e 


#
# Install Docker and Docker Compose
#

export LTS="$(curl -s https://nodejs.org/dist/index.json | jq -r 'map(select(.lts))[0].version')"

on_chroot << EOF
uname -a

echo "Installing Node.js $LTS..."

set -e
set -x

curl -Lsf "https://nodejs.org/dist/$LTS/node-$LTS-linux-armv6l.tar.gz" | tar xzf - -C /usr/local --strip-components=1 --no-same-owner

node -v
npm -v
EOF
