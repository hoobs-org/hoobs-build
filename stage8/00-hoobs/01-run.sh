#!/bin/bash -e 

##################################################################################################
# hoobs-build                                                                                    #
# Copyright (C) 2019 HOOBS                                                                       #
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

install -m 644 files/sudoers "${ROOTFS_DIR}/etc/"
install -m 644 files/hoobs.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/hoobs-core.tgz "${ROOTFS_DIR}/"

on_chroot << EOF
npm uninstall -g @hoobs/hoobs
npm install -g --unsafe-perm /hoobs-core.tgz
rm -rf /hoobs-core.tgz
setcap CAP_NET_BIND_SERVICE=+eip /usr/local/lib/node_modules/@hoobs/hoobs/bin/hoobs
setcap CAP_NET_BIND_SERVICE=+eip /usr/local/bin/node
systemctl daemon-reload
systemctl enable hoobs
EOF
