#!/bin/bash

success() {
    echo -e "$(tput setaf 2)$@$(tput sgr0)"
}

warn() {
    echo -e "$(tput setaf 3)$@$(tput sgr0)"
}

error() {
    echo -e "$(tput setaf 1)$@$(tput sgr0)"
    exit 1
}

if [ -z "$1" ]; then
    error "You must specify an image to mount!"
else
    if [ ! -f "$*" ]; then
        error "That image does not exist!"
    fi
fi

 if [ "$EUID" -ne 0 ]; then
    if [ -z "$SUDO_COMMAND" ]; then
        warn "This script must be run as root, recalling self with sudo..."
        sudo $0 $*
        exit 0
    else
        error "This script must be run as root"
    fi
fi

if [ -d "/mnt/cdrom" ]; then
    if mount | grep /mnt/cdrom > /dev/null; then
        error "A CD-ROM has already been mounted..."
    fi
else
    mkdir -p /mnt/cdrom
fi

mount -o loop -t iso9660 "$*" /mnt/cdrom
cd /mnt/cdrom
ls -l
