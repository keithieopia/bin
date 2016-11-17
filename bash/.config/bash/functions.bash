have() { type "$1" &> /dev/null; } # determine if a program in installed
quietly() { "$@" &>/dev/null; } # Run a command quietly


# Calculate size of directories
dudir() {
    echo "size of directories in MB"
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
        echo "you did not specify a directy, using pwd"
        DIR=$(pwd)
        find $DIR -maxdepth 1 -type d -exec du -sh \{\} \; | sort -nr
    else
        find $1 -maxdepth 1 -type d -exec du -sh \{\} \; | sort -nr
    fi
}


##
## Archiving
##
mktar() {  tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() {  tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz2() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }


##
## Groups
##
enlist() {
    for group in ${@}; do
        sudo gpasswd -a ${USER} ${group}
    done
}

resign() {
    for group in ${@}; do
        sudo gpasswd -d ${USER} ${group}
    done
}


##
## Base conversion, useful for webdev and programming
##
hex2dec() { echo $((16#$1)); }
dec2hex() { echo $(bc <<< "obase=16; $1"); }
hex2ascii() { echo -e "\0$(printf %o $((16#$1)))"; }
ascii2hex() { echo $(hexdump -e '"%X"' <<< "$1"); }


##
## Arch Linux's pacman package manager
##
if [[ -e /etc/arch-release ]]; then
    upgrade() {
        echo "$HOSTNAME: Updating system..."
        sudo pacman -Syu "$@"
    }

    update() {
        echo "$HOSTNAME: Updating package lists..."
        sudo pacman -Sy "$@"
    }

    purge() {
        echo "$HOSTNAME: Removing package..."
        sudo pacman -Rsnc "$@"
    }

    browse() {
        pacman -Qs "$@"
    }

    consider() {
        (pacman -Si ${*} || packer -Si ${*}) | $PAGER;
    }

    hunt() {
        packer -Ss "${@}" | $PAGER
    }
fi
