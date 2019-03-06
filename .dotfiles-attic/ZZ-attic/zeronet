#!/bin/bash

have() { type "$1" &> /dev/null; } # determine if a program in installed

ask() {
    # http://djm.me/ask
    local prompt default REPLY

    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read REPLY </dev/tty

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

browser() {
    if have firefox && ask "Start firefox?" Y; then
        firefox --private-window "http://127.0.0.1:43110" >/dev/null 2>&1
    fi
}

if ! have zeronet; then
    echo "ZeroNet is not installed!"
    exit 1
fi

if systemctl is-active zeronet >/dev/null 2>&1; then
    echo "ZeroNet is already running!"

    if ask "Shutdown ZeroNet?" N; then
        sudo systemctl stop zeronet

        if systemctl is-active tor >/dev/null 2>&1; then
            if ask "Shutdown tor too?" Y; then
                sudo systemctl stop tor
            fi
        fi
    else
        browser
    fi

    exit
fi

if have tor; then
    if ! systemctl is-active tor >/dev/null 2>&1; then
        echo "Starting tor and allowing it time to bootstrap..."
        sudo systemctl start tor
        sleep 10s
    fi
fi

# Permissions check
if ! ls -l /etc/zeronet.conf | awk '{print $3}' | grep -q 'zeronet'; then
    echo "Fixing permissions..."
    sudo chown zeronet:zeronet /etc/zeronet.conf
fi

echo "Starting zeronet..."
sudo systemctl start zeronet

if [ "$?" -eq "0" ]; then
    browser
else
    echo "ZeroNet didn't appear to start!"
    exit 1
fi
