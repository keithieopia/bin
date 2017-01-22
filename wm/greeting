#!/bin/bash

suffix() {
    case `date +%d` in
        1|21|31) echo "st" ;;
        2|22)    echo "nd" ;;
        3|23)    echo "rd" ;;
        *)       echo "th" ;;
    esac
}

DATE=$(date "+%A, %B, %e$(suffix)") # e.g.: Sunday, January 1st
TIME="$(date '+%l:%M %p')"
HOUR=$(date '+%H')


#
# Sets the volume to an appropriete level given the time
#
if [ "$HOUR" -ge 8 ] && [ "$HOUR" -lt 21 ]; then
    amixer -D pulse set Master 50%
else
    amixer -D pulse set Master 20%
fi


#
# Plays a greeting depending on the time
#
if [ "$HOUR" -ge 17 ] || [ "$HOUR" -lt 5 ]; then
    GREETING="Good evening"
elif [ "$HOUR" -ge 12 ]; then
    GREETING="Good afternoon"
else
    GREETING="Good morning"
fi

paplay "$HOME/bin/assets/sounds/startup.ogg"
say "$GREETING. Today is $DATE. It is $TIME"
