#!/bin/bash

# INSTALLATION
# ------------
# to use this script by default instead of plain vanilla firefox, copy
# or symlink this script to '/usr/local/bin':
#
#    ln -s ~/bin/wm/firefox /usr/local/bin/firefox
#
#
# WHITELIST NOTES
# ---------------
# ~/dotfiles/sys/firefox
# ~/dotfiles/flash
#    gnu stow directory that contains 'mozilla.cfg' and '.asoundrc'.
#    gnu stow symlinks files by default which causes issues with
#    firejail since firejail will not follow symlinks without 
#    whitelisting the symlink's target directory
#
# ~/projects/startpage
#    just a simple html page used for my browser's homepage

firejail --whitelist=~/dotfiles/sys/firefox \
         --whitelist=~/projects/startpage \
         /usr/bin/firefox "$@"