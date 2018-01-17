# quicker cd'ing
function cdup() {
    [[ -z $@ ]] && echo -e "cd out of directory quicker\nusage: cdup <#ofdirs>" && return 1

    local x="";
    for i in $(seq $1); do
        x="$x../"
    done

    cd $x
}

# Calculate size of directories
function dudir() {
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

function mkzip() { zip -r "${1%%/}.zip" "${1%%/}/"; }

function mktar() { tar cvf  "${1%%/}.tar" "${1%%/}/"; }

function mktbz() {
    if type pbzip2 &> /dev/null; then
        echo -e "\033[1;37mUsing parallel pbzip2...\033[00m"
        tar -Ipbzip2 -cvf "${1%%/}.tbz2" "${1%%/}/"
    else
        tar cvjf "${1%%/}.tbz2" "${1%%/}/"; 
    fi
}

function mktgz() {
    if type pigz &> /dev/null; then
        echo -e "\033[1;37mUsing parallel pigz...\033[00m"
        tar -Ipigz -cvf "${1%%/}.tgz" "${1%%/}/"
    else
        tar cvzf "${1%%/}.tgz"  "${1%%/}/"
    fi
}

function mktxz() {
    if type pxz &> /dev/null; then
        echo -e "\033[1;37mUsing parallel pxz...\033[00m"
        tar -Ipxz -cvf "${1%%/}.txz" "${1%%/}/"
    else
        tar cvJf "${1%%/}.txz" "${1%%/}/"
    fi
}

##
## Groups
##
function enlist() {
    for group in ${@}; do
        sudo gpasswd -a ${USER} ${group}
    done
}

function resign() {
    for group in ${@}; do
        sudo gpasswd -d ${USER} ${group}
    done
}


##
## Base conversion, useful for webdev and programming
##
function hex2dec() { echo $((16#$1)); }
function dec2hex() { echo $(bc <<< "obase=16; $1"); }
function hex2ascii() { echo -e "\0$(printf %o $((16#$1)))"; }
function ascii2hex() { echo $(hexdump -e '"%X"' <<< "$1"); }

function calc() { echo "scale=4;$*" | bc -l; }

##
## Search Engines
##

function encode() { echo -n $@ | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'; }

function google() { 
    if [ $# -eq 0 ]; then
        xdg-open "https://www.google.com/"
    else
        xdg-open "https://www.google.com/search?hl=en#q=$(encode $@)"
    fi
}

function wiki() {
    if [ $# -eq 0 ]; then
        xdg-open "https://en.wikipedia.org/wiki/Main_Page"
    else
        xdg-open "https://en.wikipedia.org/w/index.php?search=$(encode $@)"
    fi
}

function ddg() {
    if [ $# -eq 0 ]; then
        xdg-open "https://duckduckgo.com/"
    else
        xdg-open "https://duckduckgo.com/?q=$(encode $@)"
    fi
}

function bing-vid() { 
    if [ $# -eq 0 ]; then
        xdg-open "http://www.bing.com/videos/explore"
    else
        xdg-open "http://www.bing.com/videos/search?q=$(encode $@)"
    fi
}

alias search="ddg"

function weather() {
    if [ -f "$HOME/.bash_secrets" ]; then
        source "$HOME/.bash_secrets"
        curl "wttr.in/$LOCATION_CITY"
    fi
}

function open-port() {
    if [ $# -eq 0 ]; then
        echo "You must specify a port..."
        exit 1
    fi

    sudo firewall-cmd --zone=public --add-port=$1 --permanent
    sudo firewall-cmd --reload
}
