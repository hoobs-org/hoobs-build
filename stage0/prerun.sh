#!/bin/bash -e

if [ ! -d "${ROOTFS_DIR}" ]; then
	bootstrap ${RELEASE} "${ROOTFS_DIR}" http://mirrors.ocf.berkeley.edu/raspbian/raspbian/
fi
