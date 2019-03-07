#
# alias
#

# helper function to see if programs are installed
have() { command -v foo >/dev/null 2>&1 ; }

################################################################################
# default flags to built-in programs
##

alias ps='ps -auxf'
alias du='du -ach 2>/dev/null | sort -h | less'
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

have colordiff && alias diff='colordiff'
have dcfldd && alias dd='dcfldd'
have top && alias top='htop'
have pydf && alias df='pydf'
have ncdu && alias du='ncdu'
have gpg2 && alias gpg='gpg2'

################################################################################
# ls
##

if ls --version | grep -q GNU; then
	# GNU coreutils only
	alias ls='ls --color --group-directories-first -AFh'
else
	# BSD like
	alias ls='ls -AFhG'
fi

# k is a zsh plugin (see .zshrc)
alias l='k -h --group-directories-first'
alias ll='k -h --group-directories-first | less -R'
alias lsd='k -h -d' # list only directories

# steam trains are nice, but this suits me better
alias sl='ls $@ | lolcat'

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
alias timestamp='date +%s'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias copy='rsync -WaPh ' # cp with progress indicator
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e' # like pgrep, but better
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dsize="pwd && du -h . 2>/dev/null | tail -1 | awk '{print $1}'"
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
alias ip='curl ifconfig.me'
alias whois='echo $1 | nc whois.internic.net 43 | sed '/NOTICE:/q' | head -n -4 -'

# sudo
alias fuck='sudo $(history -p !!)' # some people are nice and call this "please"
alias sedit='sudo nvim'

# services
alias start='sudo systemctl start '
alias stop='sudo systemctl stop '
alias restart='sudo systemctl restart '
alias status='systemctl status '
alias syslog='journalctl -u '
