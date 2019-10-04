#!/bin/bash -e 


#
# Install Node.js
# Installing the arm32v6 version of Node to ensure compilability with RaspberryPi 1 / Zero
#

on_chroot << EOF
uname -a

echo "Installing Node.js"

set -e
set -x

npm install -g n

n stable

node -v
npm -v
EOF
