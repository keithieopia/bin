# Determine if a program is installed, used in this script
have() { type "$1" &> /dev/null; }

# safer commands
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# better programs
have dcfldd && alias dd='dcfldd'
have htop && alias top='htop'
have colordiff && alias diff='colordiff'
have pydf && alias df='pydf'

# default options
alias du='du -ch'
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lah'
alias dir='dir --color=auto'
alias mkdir='mkdir -p'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ps='ps auxf'
alias pg='ps aux | grep'
alias ping='ping -c 5'
have shred && alias shred='shred -fuzvn 1'
have wget && alias wget='wget -c'
have unclutter && alias unclutter='unclutter -idle 1 -root -grab -visible'

# new commands
alias home='cd ~ && clear'
alias trash="mv -t ~/.local/share/Trash/files --backup=t"
alias reload='source ~/.bashrc'
alias snano='sudo nano'
alias ..="cd .."
alias epoch='date +%s'
alias fuck='sudo $(history -p !!)'

quietly () { "$@" &>/dev/null; }

##
## Figure out stuff about our environment
##

is_ssh () {
    if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
        return 0
    else
        return 1
    fi
}

is_root () {
    PRIV=1
    if [ `/usr/bin/id -u` -eq 0 ]; then
        PRIV=0
    fi
    return $PRIV
}

##
## Network
##

# list open ports
alias ports='sudo lsof -i -n -P'

# list running local servers
alias opennet='sudo lsof -i'

# Websites
alias google="firefox -P Browsing http://www.google.com"
alias wiki="firefox -P Browsing http://en.wikipedia.org/wiki/Main_Page"

# Get public IP address
myip () { wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'; }


##
## Directory Functions
##

# list only dirs
alias lsd='ls -l | grep "^d"'   #list only directories

# find biggest file in a dir
alias biggest='find . -type f -exec ls -s {} \; | sort -n -r | head -5'

# counts num of files in a dir
alias filecount="echo $(ls -1 | wc -l)"

# Makes dir then cd into it
mkcdr () {
    mkdir -p -v $1
    cd $1
}

# Calculate size of directories
ds () {
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
## Arch Linux's pacman package manager
##
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


##
## Groups
##

enlist () {
    for group in ${@}; do
        sudo gpasswd -a ${USER} ${group}
    done
}

resign () {
    for group in ${@}; do
        sudo gpasswd -d ${USER} ${group}
    done
}


##
## Security
##

# generate a random password $1 = length (default 8),
# set $2 to 0 for no special chars
randpass () {
    if [[ $2 == "!" ]]; then
        echo $(cat /dev/urandom | tr -cd '[:graph:]' | head -c ${1:-8})
    else
        echo $(cat /dev/urandom | tr -cd '[:alnum:]' | head -c ${1:-8})
    fi
}


##
## Fun Stuff
##

# rot13 caesar cipher
rot13 () { echo $@ | tr A-Za-z N-ZA-Mn-za-m; }

# Look super busy
bullshit () { cat /dev/urandom | hexdump -C | grep --color=auto "ca fe"; }

# Excuses
bofh () {
    # telnet bofh.jeffballard.us 666 2>/dev/null | grep --color -o "Your excuse is:.*$";
    ## instead of above, download excuses locally and use internal randomline()
    ## wget http://pages.cs.wisc.edu/~ballard/bofh/excuses

    randomline ~/bin/data/bofh;
}


##
## Archiving
##

mktar () { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz () { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz () { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }


##
## Convert Hex Numbers into different bases
## Useful for website development or programming
##

# Convert a hex number to different bases
hex2all () {
    if [[ $1 ]]; then
        echo "$1 in hexadecimal also equals:"
        echo "  binary:  $(hex2bin $1)"
        echo "  octal:   $(hex2oct $1)"
        echo "  decimal: $(hex2dec $1)"
        echo "  base32: $(hex2b32 $1)"
        echo "  base64: $(hex2b64 $1)"
        echo "  ascii:   $(hex2asc $1)"
    fi
}

hex2asc () { echo -e "\0$(printf %o $((16#$1)))"; }
hex2bin () { echo "obase=2 ; ibase=16 ; $1" | bc; }
hex2b64 () { echo "obase=64 ; ibase=16 ; $1" | bc; }
hex2b32 () { echo "obase=32 ; ibase=16 ; $1" | bc; }
hex2dec () { echo $((16#$1)); }
hex2oct () { echo "obase=8 ; ibase=16 ; $1" | bc; }


##
## Text file operations
##

# get a random line from a file
randomline () {
    if [ "$1" ];then  #checking if we were passed a filename/variable
        FileName="$1"  #just an easier variable to work with
        if [ ! -f "$FileName" ];then  #check if it is a file
            echo "Err: $FileName is not a file"
        fi
        #Count how many lines in the file
        LineCount="$(wc -l "$FileName" | cut -f 1 -d ' ')"
        #Dont continue if we have less than 1 line
        if [ "$LineCount" -gt "1" ];then
            #Test past.. selecting random line
            TargetLine=$[ ( $RANDOM % $LineCount )  + 1 ]
            Output="$(sed -n "${TargetLine}p" "$FileName")"
            echo "$Output"
        else
            echo need a file with more than 1 line... cmon...
        fi
    else
        #seems we didnt get any input
        echo "Please specify a text file"
    fi
}

# Character / Word counts
alias charcount='wc -c $1'
alias wordcount='wc -w $1'

# Most frequent used words of text file
word_freq () {
    cat "$1" | tr -cs "[:alnum:]" "\n"| tr "[:lower:]" "[:upper:]" | awk '{h[$1]++}END{for (i in h){print h[i]" "i}}'|sort -nr | cat -n | head -n 30
}
