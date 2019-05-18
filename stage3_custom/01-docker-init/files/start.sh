#!/bin/bash

# Attempt to set timezone based on geoip
/usr/local/bin/tzupdate

export TZ=$(cat /etc/timezone)

echo "TZ=\"$TZ\"" > /home/hoobs/.env

/usr/local/bin/docker-compose -f /home/hoobs/docker-compose.yml --project-directory /home/hoobs up -d
