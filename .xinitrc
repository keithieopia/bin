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

# Xorg stuff:
xset s 600 600 1800            # monitor powersaving
xset -b                        # no friggen beep
xsetroot -cursor_name left_ptr # set cursor so it's not an X

##
## Mount user .cache folder if not already done
##



# Autostart apps:
~/bin/wm/startup-sound &
~/bin/mount-cache &
compton &
~/.fehbg &
unclutter &
urxvtd -q -f -o &
pcmanfm -d &
~/bin/wm/lemonade &

# Autostart network specific apps:
~/bin/wm/autostart-net &
sudo ~/bin/wm/autostart-net-trusted &

# bspwm specific stuff:
sxhkd &
~/bin/wm/floating-desktop &
exec bspwm > .xinit.log 2>&1
