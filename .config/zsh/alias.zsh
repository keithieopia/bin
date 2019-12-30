#
# alias
#

# helper function to see if programs are installed
have() { command -v foo >/dev/null 2>&1 ; }

################################################################################
# default flags to built-in programs
##

alias ps='ps -auxf'
alias du='du -h'
alias mkdir='mkdir -pv'
alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ping='ping -c 5'
alias wget='wget -c'
alias free='free -ht'

# safer commands
alias rm="rm -Iv"
alias cp="cp -iv"
alias mv="mv -iv"

have shred && alias shred='shred -fuzvn 1'

################################################################################
# if available, replace coreutils with more feature rich programs
##

have dcfldd && alias dd='dcfldd'
have top && alias top='htop'
have pydf && alias df='pydf'
have ncdu && alias du='ncdu'
have gpg2 && alias gpg='gpg2'

###############################################################################
# colors: taste the rainbow
##

have colordiff && alias diff='colordiff'
have pygmentize && alias cat='pygmentize -O style=monokai -f console256 -g '

################################################################################
# aliases for Linux programs to point to the FreeBSD alternate command
##
if uname | grep -q FreeBSD; then
	alias dig="drill"
fi

################################################################################
# ls
##

if zgen list | grep -q "k.plugin.zsh"; then
	# k is a zsh plugin (see .zshrc)
	alias ls='k -h --group-directories-first'
	alias lsl='k -h --group-directories-first | less -R'
	alias lsd='k -h -d' # list only directories
elif ls --version 2>/dev/null | grep -q GNU; then
	# GNU coreutils only
	alias ls='ls --color --group-directories-first -AFh'
else
	# BSD like
	alias ls='ls -AFhG'
fi

# steam trains are nice, but this suits me better
have lolcat && alias sl='ls $@ | lolcat' || function sl() {
	# settle for a Monty Python insult if we don't have lolcat
	tput setaf 5
	echo "  You empty headed animal food trough wiper"
	echo "  I fart in your general direction"
	echo "  Your mother was a hamster and your father smelt of elderberries"
	echo
	tput bold
	sleep 1 && /bin/ls -Fhx "$@"
	tput sgr0
	tput setaf 5
	echo
	echo "  Now go away or I shall taunt you a second time!"
}

################################################################################
# new commands
##

# navigation
alias ~='cd $HOME && clear'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias md="take" # included with oh-my-zsh; makes a dir and cd's into it
alias trash="mv -t ~/.local/share/Trash/files --backup=t"
alias yd="youtube-dl"
alias timestamp='date +%s'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias copy='rsync -WaPh ' # cp with progress indicator
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e' # like pgrep, but better
alias dirsize="pwd && du -h . 2>/dev/null | tail -1 | awk '{print $1}'"
alias duless='du -ach 2>/dev/null | sort -h | less'
alias wifi-scan='nmcli dev wifi list'
alias ddstatus='pgrep -x dd && pkill -SIGUSR1 dd || echo "dd is not running!"'
alias search="ddg" # see functions.zsh 

# git
alias push='git push'
alias clone='git clone'
alias undopush='git push -f origin HEAD^:master'
alias undocommit='git reset --soft HEAD~1'

# permissions
alias chrw='chmod ug+rw'
alias chx='chmod +x'
alias mine='sudo chown ${USER}:${USER}'

# networking
alias openports='sudo lsof -i -n -P' # list open ports / running network services
alias whatismyip='curl ifconfig.me'
alias whois='echo $1 | nc whois.internic.net 43 | sed '/NOTICE:/q' | head -n -4 -'
alias downthemall='youtube-dl -a download.txt'

# sudo
alias fuck='sudo $(history -p !!)' # some people are nice and call this "please"
alias sedit='sudo nvim'
alias halt='sudo halt'
alias reboot='sudo reboot'

# services
alias start='sudo systemctl start '
alias stop='sudo systemctl stop '
alias restart='sudo systemctl restart '
alias status='systemctl status '
alias syslog='journalctl -u '
