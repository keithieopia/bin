# make directory and cd into it
md() { mkdir -p "$@" && cd "$@"; }

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

# lesspipe for non-text input files
if type lesspipe &> /dev/null; then
	eval "$(SHELL=/bin/sh lesspipe)"
fi

##
## Archiving
##

mkzip() { zip -r "${1%%/}.zip" "${1%%/}/"; }

mktar() { tar cvf  "${1%%/}.tar" "${1%%/}/"; }

mktbz2() {
    if type pbzip2 &> /dev/null; then
        echo -e "\033[1;37mUsing parallel pbzip2...\033[00m"
        tar -Ipbzip2 -cvf "${1%%/}.tbz2" "${1%%/}/"
    else
        tar cvjf "${1%%/}.tbz2" "${1%%/}/"; 
    fi
}

mktgz() {
    if type pigz &> /dev/null; then
        echo -e "\033[1;37mUsing parallel pigz...\033[00m"
        tar -Ipigz -cvf "${1%%/}.tgz" "${1%%/}/"
    else
        tar cvzf "${1%%/}.tgz"  "${1%%/}/"
    fi
}

mktxz() {
    if type pixz &> /dev/null; then
        echo -e "\033[1;37mUsing parallel pixz...\033[00m"
        tar -Ipixz -cvf "${1%%/}.txz" "${1%%/}/"
    else
        tar cvJf "${1%%/}.txz" "${1%%/}/"
    fi
}

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

calc() { echo "scale=4;$*" | bc -l; }

