#!/bin/bash

if [ "$(id -u)" != "0" ]; then
    if [ -z "$SUDO_COMMAND" ]; then
        echo -e "\e[33mThis script must be run as root, recalling self with sudo...\e[39m"
        sudo $0 $*
        exit 0
    else
        echo -e "\e[31mThis script must be run as root\e[39m"
        exit 1
    fi
fi

certbot certonly --email timothykeith@gmail.com --webroot -w /var/lib/letsencrypt/ \
-d keithieopia.com -d www.keithieopia.com \
-d kerrikeith.com  -d www.kerrikeith.com
