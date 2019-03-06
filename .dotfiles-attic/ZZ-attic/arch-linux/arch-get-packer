#!/bin/bash

have() { type "$1" &> /dev/null; } # determine if a program in installed

#
# Sanity checks...
#
if have packer; then
    echo "packer is already installed!"
    exit 1
fi

if [[ -e /etc/arch-release ]]; then
    echo "This does not appear to be an Arch Linux system!"
    exit 1
fi


#
# Dependency checks...
#
DEPENDANCES=( 'jshon' 'expac' 'git' )

for package in "${DEPENDANCES[@]}"; do
    if ! have $package; then
        if [ -z "$INSTALL" ]; then
            INSTALL="$package"
        else
            INSTALL="$INSTALL $package"
        fi
    fi
done

if [ -n "$INSTALL" ]; then
    echo "Installing dependencies for packer: $INSTALL"
    sudo pacman -S "$INSTALL"
fi


#
# Actually download and install packer
#
mkdir /tmp/packer && cd /tmp/packer

curl https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer > PKGBUILD
makepkg

sudo pacman -U packer-*.pkg.tar.xz || {
    rm /tmp/packer/*
    rmdir /tmp/packer
}
