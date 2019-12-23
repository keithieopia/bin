#!/bin/bash

ALLOW_COUNTRY="US"

if [ $# -ne 1 ]; then
  echo "Usage:	$(basename $0) <ip>"
  exit 0
fi

COUNTRY=$(/usr/bin/geoiplookup $1 | awk -F ': ' '{print $2}' | awk -F ',' '{print $1}')

if grep -wq "$ALLOW_COUNTRY" <<< "$COUNTRY"; then
  echo "$(date '+%F %T') ALLOW sshd connection from $1 ($COUNTRY)" >> /var/log/sshgeofilter.log
  exit 0
else
  echo "$(date '+%F %T') DENY sshd connection from $1 ($COUNTRY)" >> /var/log/sshgeofilter.log
  exit 1
fi
