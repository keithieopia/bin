if hash toilet 2>/dev/null && hash lolcat 2>/dev/null; then

    # output only if we're in SSH
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then 
        toilet -f smblock " See You Space Cowboy... " --filter border | lolcat
        sleep 2

    # output if not in a virtual terminal
    elif tty | grep -q /dev/pts; then
        toilet -w $(tput cols) --font pagga "So Long, and Thanks for All the Fish" | lolcat 
        sleep 2
    fi
fi