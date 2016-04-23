##
## Arch Linux's pacman package manager
##

if [[ -e /etc/arch-release ]]; then
    upgrade () {
        echo "$HOSTNAME: Updating system..." | colorize BOLDBLUE
        sudo pacman -Syu "$@"
    }

    update () {
        echo "$HOSTNAME: Updating package lists..." | colorize BOLDBLUE
        sudo pacman -Sy "$@"
    }

    purge () {
        echo "$HOSTNAME: Removing package..." | colorize BOLDBLUE
        sudo pacman -Rsnc "$@"
    }

    browse () {
        pacman -Qs "$@"
    }

    consider () {
        (pacman -Si ${*} || packer -Si ${*}) | $PAGER;
    }

    hunt () {
        packer -Ss "${@}" | $PAGER
    }
fi
