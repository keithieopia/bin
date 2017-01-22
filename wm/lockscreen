#!/bin/bash

IMAGE="/tmp/i3lock.png"
LOCK_IMAGE="$HOME/bin/assets/lockscreen/barney-fife.png"

# All options are here: http://www.imagemagick.org/Usage/blur/#blur_args
#BLUR="0x5" # 1.132s
#BLUR="0x2" # 0.956s
BLUR="5x3" # 0.935s
#BLUR="2x8" # 0.854s
#BLUR="2x3" # 0.826s


usage () {
cat <<HELP
Locks the screen with a neat pixelated effect

Usage: $(basename "$0")


https://github.com/keithieopia/bin/

Copyright (c) 2016 - 2017 Timothy Keith
Licensed under the MIT License.
HELP
}

if [ "$1" == "-h" ]; then
    usage
    exit
fi

# Dependancy check
DEPENDANCES=( 'i3lock' 'scrot' 'convert' )

have() { type "$1" &> /dev/null; }
for program in "${DEPENDANCES[@]}"; do
    if ! have $program; then
        echo "$(basename $0) requires $program to run!"
        exit 1
    fi
done


if have say; then
    paplay "$HOME/bin/assets/sounds/warning.ogg"
    say "Commencing screen lock"
fi

# Generate the background image
scrot $IMAGE

convert $IMAGE -brightness-contrast -30x10 -level 0%,100%,0.6 -blur $BLUR -gravity center - | \
composite -gravity center -gravity south $LOCK_IMAGE - $IMAGE


# lock the screen with the following options:
#   1. ignore empty passwords
#   2. show wrong password count on unlock
#   3. set a background image
i3lock -e -f -i $IMAGE

# remove the lock image afterwards
rm $IMAGE

# Play sound once screen is locked
if have say; then
    paplay "$HOME/bin/assets/sounds/success.ogg"
    say "Lock completed"
fi
