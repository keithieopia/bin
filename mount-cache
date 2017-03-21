#!/bin/bash

usage () {
cat <<HELP
Create folders and files expected to be in ~/.cache normally

Usage: $(basename "$0")
   -d : Print debug information


https://github.com/keithieopia/bin/

Copyright (c) 2016 Timothy Keith
Licensed under the MIT license.
HELP
}

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


while [ "$1" != "" ]; do
case $1 in
    -d )
        DEBUG=1
        ;;
    -h )
        usage
        exit
        ;;
esac
shift
done

if mount | grep "tmpfs on $HOME/.cache" > /dev/null; then
    if [ ! -f "$HOME/.cache/.lock" ]; then

        mkdir "$HOME/.cache/thumbnails"
        mkdir "$HOME/.cache/flash"

        # Create lockfile used to test if .cache has been populated yet
        touch "$HOME/.cache/.lock"
        [[ $DEBUG == "1" ]] && success "~/.cache setup!"
    else
        [[ $DEBUG == "1" ]] && warn "~/.cache already setup, nothing to do..."
    fi
else
    [[ $DEBUG == "1" ]] && warn "~/.cache is not mounted as tmpfs, nothing to do..."
fi
