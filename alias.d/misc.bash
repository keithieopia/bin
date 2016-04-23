# better programs
have dcfldd && alias dd='dcfldd'
have htop && alias top='htop'
have colordiff && alias diff='colordiff'
have pydf && alias df='pydf'

# new commands
alias ..="cd .."
alias ~='cd ~ && clear'
alias trash="mv -t ~/.local/share/Trash/files --backup=t"
alias reload='source ~/.bashrc'
alias snano='sudo nano'
alias pg='ps aux | grep'
alias epoch='date +%s'
alias fuck='sudo $(history -p !!)'

# Run a command quietly
quietly () { "$@" &>/dev/null; }

# Groups
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

# generate a random password $1 = length (default 8),
# set $2 to 0 for no special chars
randpass () {
    if [[ $2 == "!" ]]; then
        echo $(cat /dev/urandom | tr -cd '[:graph:]' | head -c ${1:-8})
    else
        echo $(cat /dev/urandom | tr -cd '[:alnum:]' | head -c ${1:-8})
    fi
}

# Look super busy
bullshit () { cat /dev/urandom | hexdump -C | grep --color=auto "ca fe"; }

mp32ogg () { ffmpeg -i "$1" -c:a libvorbis -q:a 4 "${1%\.*}.ogg"; }