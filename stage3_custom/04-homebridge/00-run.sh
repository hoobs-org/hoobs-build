#!/bin/bash -e

install -v -d -o 1000 -g 1000				"${ROOTFS_DIR}/var/lib/homebridge/node_modules"
install -v -m 644 -o 1000 -g 1000 files/config.json	"${ROOTFS_DIR}/var/lib/homebridge/"
install -v -m 644 -o 1000 -g 1000 files/package.json    "${ROOTFS_DIR}/var/lib/homebridge/"
