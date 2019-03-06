#!/bin/bash

# Returns an apt-cacher-ng proxy address if we're on our home network, otherwise
# tells apt to directly connect to apt repos. Useful for laptops
#
# Set "Acquire::http::Proxy-Auto-Detect" in apt.conf to use this script

PROXY_IP="10.0.0.50"

# HOME_GATEWAY="00:11:22:AA:BB:CC"
# this script provides $HOME_GATEWAY
. /home/timothy/.bash_secrets

GATEWAY=$(ip neigh | grep $(ip route show match 0/0 | awk '{print $3}') | awk '{print $5}')

if [ "$GATEWAY" = "$HOME_GATEWAY" ]; then
  if ping -i 0.2 -c 1 $PROXY_IP &>/dev/null; then
    echo "http://${PROXY_IP}:3142"
    exit 0
  fi
fi

echo "direct://"
