# .bash_profile
#    read by Bash on start, regardless of interactivity. should not include
#    anything that outputs to stdin.
#
#    Recommended reading:
#    https://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile/183980#183980

# if we're running interactively
case "$-" in
    *i*)
		# if '~/.bashrc' exists, source it
        if [[ -f ~/.bashrc ]]; then
            . ~/.bashrc
        fi
        
        # Start X on login if we're on TTY 1 (the default TTY)
        if [[ -z "$DISPLAY" && "$(tty)" == "/dev/tty1" ]]; then
			exec startx -- vt1 -keeptty -nolisten tcp > ~/.xorg.log 2>&1
		fi
		;;
esac
