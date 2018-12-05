#!/bin/bash

# INSTALLATION
# ------------
# to use this script by default instead of plain vanilla dropbox, copy
# or symlink this script to '/usr/local/bin':
#
#    ln -s ~/bin/wm/dropbox /usr/local/bin/dropbox

# stop dropbox if it's already running

PID=$(pgrep -o dropbox)
if [[ "$PID" != "$$" ]]; then
    echo "dropbox is already running, stopping it..."
    kill -9 $PID
fi


# stop dropbox from downloading updates and trying to install them. it's really
# buggy under linux and fails to install, making dropbox waste bandwidth
# needlessly. You are probably using distro's package manager anyway...
if [ -w "~/.dropbox-dist" ]; then
    echo "nuking dropbox's auto-update mechanism..."
    rm -rf ~/.dropbox-dist
    install -dm0 ~/.dropbox-dist
fi


# ionice -c 3
#    run sandbox only when disk is idle
# firejail --nice=7
#    run dropbox nicely, so it doesn't hog the cpu
ionice -c 3 firejail --nice=7 /usr/bin/dropbox
