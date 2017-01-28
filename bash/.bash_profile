# .bash_profile
#    read by Bash on start, regardless of interactivity. should not include
#    anything that outputs to stdin.
#
#    Recommended reading:
#    https://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile/183980#183980

# if we're running interactively and '~/.bashrc' exists, source it
case "$-" in
    *i*)
        if [[ -f ~/.bashrc ]]; then
            . ~/.bashrc
        fi
esac

##
## Start X on login if we're on TTY 1 (the default TTY)
##
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
