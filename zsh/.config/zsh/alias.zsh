#
# alias
#

# safer commands
alias rm="rm -Iv"
alias cp="cp -iv"
alias mv="mv -iv"

# defaults to built-in programs
alias ps='ps auxf'
alias du='du -ch'
alias mkdir='mkdir -p -v'
alias dir='dir --color=auto'
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ping='ping -c 5'

# Fix noisy apps to be silent
alias kate='kate >/dev/null 2>&1'
alias retext='retext >/dev/null 2>&1'

# defaults to optional programs
if type shred &> /dev/null; then 
	alias shred='shred -fuzvn 1'
fi

# replace built-ins with better programs if we have them
if type colordiff &> /dev/null; then 
	alias diff='colordiff'
fi

if type dcfldd &> /dev/null; then
	alias dd='dcfldd'
fi

if type htop &> /dev/null; then
	alias top='htop'
fi

if type pydf &> /dev/null; then
	alias df='pydf'
fi

if type gpg2 &> /dev/null; then
	alias gpg='gpg2'
fi

# new commands
alias ..="cd .."
alias ...="cd ..."
alias ....="cd ...."
alias ~='cd ~ && clear'
alias md="take" # included with oh-my-zsh; makes a dir and cd's into it
alias trash="mv -t ~/.local/share/Trash/files --backup=t"
alias epoch='date +%s'
alias fuck='sudo $(history -p !!)' # some people are nice and call this "please"
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias cp-progress='rsync -WavPh $1 $2' # cp with progress indicator
alias lsd='ls -l | grep "^d"' # list only dirs
alias ll='ls -lhA --color | less -R'
alias ports='sudo lsof -i -n -P' # list open ports / running network services
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e' # like pgrep, but better

# sudo
alias snano='sudo nano'
alias ufw='sudo ufw'

# services
alias start='sudo systemctl start '
alias stop='sudo systemctl stop '
alias restart='sudo systemctl restart '
alias status='systemctl status '

alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
