##
## Source .bashrc if it exists
##

[[ -f ~/.bashrc ]] && . ~/.bashrc

##
## Start X on login if we're on TTY 1 (the default TTY)
##
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
