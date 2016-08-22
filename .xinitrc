#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Blank the monitor after 10mins and turn it off after 30mins
xset s 600 600 1800

# no friggen beep
xset -b

# set cursor so it's not an X
xsetroot -cursor_name left_ptr &

#
# Autostart Apps
#

compton &
~/.fehbg &
unclutter &
urxvtd -q -f -o &
pcmanfm -d &

#
# play a startup sound if it's not late
#
H=$(date +%H)
if (( 8 <= 10#$H && 10#$H < 21 )); then 
    amixer -D pulse set Master 50%
    paplay "$HOME/bin/sounds/psx.ogg" &
else
    amixer -D pulse set Master 0%
fi


#
# Window Manager
#

#exec openbox-session
exec bspwm > .xinit.log 2>&1
