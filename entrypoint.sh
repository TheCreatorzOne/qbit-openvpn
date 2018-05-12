#!/bin/bash

set -e

# Default configuration file
mkdir -p /home/qbittorrent/.config/qBittorrent

# if [ ! -f /config/qBittorrent.conf ]
# then
# 	cp /default/qBittorrent.conf /config/qBittorrent.conf
# fi

if [ ! -e /home/qbittorrent/.config/qBittorrent ]; then
  ln -s /config /home/qbittorrent/.config/qBittorrent
fi

# Allow groups to change files.
umask 002

exec "$@"

# qbittorrent-nox -v
#
# export HOME=/home/qbittorrent
# 
# su -c "$@" -p qbittorrent
