#!/bin/bash -e 


#
# Install Docker and Docker Compose
#

on_chroot << EOF
uname -a

echo "Installing Docker..."

curl -fsSL https://get.docker.com -o get-docker.sh
chmod u+x get-docker.sh
sudo VERSION=18.06 ./get-docker.sh
rm -rf get-docker.sh

sudo usermod -aG docker hoobs

echo "Installing Docker Compose..."

sudo easy_install pip
sudo pip install docker-compose~=1.23.0 tzupdate
EOF
