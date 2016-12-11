#!/bin/bash

colorize () {
    SUCCESS="0;32"
    WARN="0;33"
    ERROR="0;31"
    ESC="\033["

    COLOR=\$${1:-NORMAL}

    echo -ne "${ESC}`eval echo ${COLOR}`m"
    cat
    echo -ne "${ESC}0m"
}

if [ -z "$1" ]; then 
    echo "You must specify an image to mount!" | colorize ERROR
    exit 1
else 
    if [ ! -f "$*" ]; then
        echo "\e[31mThat image does not exist!\e[39m" | colorize ERROR
        exit 1
    fi
fi

 if [ "$EUID" -ne 0 ]; then
    if [ -z "$SUDO_COMMAND" ]; then
        echo "This script must be run as root, recalling self with sudo..." | colorize WARN
        sudo $0 $*
        exit 0
    else
        echo "This script must be run as root" | colorize ERROR
        exit 1
    fi
fi

if [ -d "/mnt/cdrom" ]; then
    if mount | grep /mnt/cdrom > /dev/null; then
        echo "A CD-ROM has already been mounted..." | colorize ERROR
        exit 1
    fi
else
    mkdir -p /mnt/cdrom
fi

mount -o loop -t iso9660 "$*" /mnt/cdrom
cd /mnt/cdrom
ls -l
