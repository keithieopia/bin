# quicker cd'ing
function cdup() {
    [[ -z $@ ]] && echo -e "cd out of directory quicker\nusage: cdup <#ofdirs>" && return 1

    local x="";
    for i in $(seq $1); do
        x="$x../"
    done

    cd $x
}

# lesspipe for non-text input files
if type lesspipe &> /dev/null; then
	eval "$(SHELL=/bin/sh lesspipe)"
fi

# auto sudo dpkg if needed
function dpkg() {
	if [ "$1" = "-i" ]; then
		sudo /usr/bin/dpkg "$@"
	else
		/usr/bin/dpkg "$@"
	fi
}

function remove-old-kernels() {
	if grep -q fedora /etc/os-release; then
		sudo dnf remove $(dnf repoquery --installonly --latest-limit=-2 -q)
	fi
}

################################################################################
# Archiving
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

################################################################################
# Groups
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


################################################################################
# Base conversion, useful for webdev and programming
##
function hex2dec() { echo $((16#$1)); }
function dec2hex() { echo $(bc <<< "obase=16; $1"); }
function hex2ascii() { echo -e "\0$(printf %o $((16#$1)))"; }
function ascii2hex() { echo $(hexdump -e '"%X"' <<< "$1"); }

function calc() { echo "scale=4;$*" | bc -l; }

################################################################################
# Search Engines
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

function weather() {
    if [ -f "$HOME/.bash_secrets" ]; then
        source "$HOME/.bash_secrets"
        curl "wttr.in/$LOCATION_CITY"
    fi
}

################################################################################
# dev servers
##

function httpserver() {
	local port="${1:-8000}"
	sleep 1 && xdg-open "http://localhost:${port}/" &
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

function phpserver() {
	local port="${1:-4000}"
	sleep 1 && xdg-open "http://localhost:${port}/" &
	php -S "localhost:${port}"
}

################################################################################
# firewall
##

function open-port() {
  if [ $# -eq 0 ] && echo "ERROR: You didn't specify a port!" && return 1

  if command -v firewall-cmd >/dev/null; then
    sudo firewall-cmd --zone=public --add-port=$1 --permanent
    sudo firewall-cmd --reload
  elif command -v ufw >/dev/null; then
    sudo ufw allow $1
  else
    echo "ERROR: firewalld or ufw is no installed!"
  fi
}

function close-port() {
  if [ $# -eq 0 ] && echo "ERROR: You didn't specify a port!" && return 1

  if command -v firewall-cmd >/dev/null; then
    sudo firewall-cmd --zone=public --remove-port=$1 --permanent
    sudo firewall-cmd --reload
  elif command -v ufw >/dev/null; then
    sudo ufw delete allow $rule
  else
    echo "ERROR: firewalld or ufw is no installed!"
  fi
}

function check-port() {
  if [ $# -eq 0 ]; then
    echo "Check if a given host's port is accessible"
    echo "usage: check-port [HOST] [PORT]"
    return 1
  fi

  if [[ ! -v $2 ]]; then
    2=$1
    1=127.0.0.1
  fi

  nc -v -z -w 3 $1 $2 &> /dev/null && echo "Online" || echo "Offline"
}

################################################################################
# images
##

function img-res() {
    if [ $# -eq 0 ]; then
        echo "print an image's resolution (width and height)"
        echo "usage: img-res <image>"
        return 1
    fi
    identify "$@" | awk '{print $3}'
}

function img-avg-color() {
    if [ $# -eq 0 ]; then
        echo "find an image's average hex color"
        echo "usage: img-avg-color <image>"
        return 1
    fi
    convert "$1" -resize 1x1 txt: | tail -1 | awk '{print $3}'
}

function base64-img() {
  FILETYPE=$(file $1 | awk '{print $2}' | tr A-Z a-z)
  IMAGE_BASE64=$(base64 -w 0 $1 | tr -d '\n')
  echo "data:image/${FILETYPE};base64,${IMAGE_BASE64}"
}

