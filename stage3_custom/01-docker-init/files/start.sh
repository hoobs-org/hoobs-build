#!/bin/bash

export TZ=$(cat /etc/timezone)

# Attempt to set timezone based on geoip
if [ "$(id -u)" = "0" ]; then
    echo "Updating system timezone..."
    /usr/local/bin/tzupdate
    export TZ=$(cat /etc/timezone)
    echo "TZ=\"$TZ\"" > /home/hoobs/.env
fi

# make a symlink to the main config directory
[ -e /home/hoobs/config ] || ln -fs /var/lib/homebridge /home/hoobs/config

/usr/local/bin/docker-compose -f /home/hoobs/docker-compose.yml --project-directory /home/hoobs up -d

