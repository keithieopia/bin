

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

[[ ! $DISPLAY && "$XDG_VTNR" = "1" && "$(tty)" = "/dev/tty1" ]] && exec startx 