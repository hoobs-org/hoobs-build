#!/bin/bash -e 

##################################################################################################
# hoobs-build                                                                                    #
# Copyright (C) 2019 HOOBS                                                                       #
# Copyright (C) 2015 Raspberry Pi (Trading) Ltd.                                                 #
#                                                                                                #
# This program is free software: you can redistribute it and/or modify                           #
# it under the terms of the GNU General Public License as published by                           #
# the Free Software Foundation, either version 3 of the License, or                              #
# (at your option) any later version.                                                            #
#                                                                                                #
# This program is distributed in the hope that it will be useful,                                #
# but WITHOUT ANY WARRANTY; without even the implied warranty of                                 #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                                  #
# GNU General Public License for more details.                                                   #
#                                                                                                #
# You should have received a copy of the GNU General Public License                              #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.                          #
##################################################################################################

mkdir -p "${ROOTFS_DIR}/lib64"

install -m 644 "files/ld-linux-aarch64.so.1" "${ROOTFS_DIR}/lib/"
install -m 644 "files/libc.so.6" "${ROOTFS_DIR}/lib64/"
install -m 644 "files/node-install.tar.gz" "${ROOTFS_DIR}/node-install.tar.gz"

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
