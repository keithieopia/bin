# safer commands
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# defaults to built-in programs
alias ps='ps auxf'
alias du='du -ch | sort -h'
alias mkdir='mkdir -p -v'
alias dir='dir --color=auto'
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ping='ping -c 5'
alias ssh="TERM=linux ssh" # SSH terminal fix

# defaults to optional programs
if type shred &> /dev/null; then 
	alias shred='shred -fuzvn 1'
fi

if type unclutter &> /dev/null; then 
	alias unclutter='unclutter -idle 1 -root -grab -visible'
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

if type xstow &> /dev/null; then
	alias stow='xstow'
fi

if type gpg2 &> /dev/null; then
	alias gpg='gpg2'
fi

# new commands
alias ..="cd .."
alias ...="cd ..."
alias ....="cd ...."
alias ~='cd ~ && clear'
alias trash="mv -t ~/.local/share/Trash/files --backup=t"
alias epoch='date +%s'
alias fuck='sudo $(history -p !!)' # some people are nice and call this "please"
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias copy='rsync -WavPh $1 $2' # cp with progress indicator
alias lsd='ls -l | grep "^d"' # list only dirs
alias ll='ls -lhA --color | less -R'
alias ports='sudo lsof -i -n -P' # list open ports / running network services
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e' # like pgrep, but better
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Websites
alias google="firefox -P Browsing http://www.google.com"
alias wiki="firefox -P Browsing http://en.wikipedia.org/wiki/Main_Page"

# sudo
alias snano='sudo nano'
alias ufw='sudo ufw'

# reload
alias reload-bash='source ~/.bashrc'
alias reload-alias='source ~/.config/bash/alias.bash'
alias reload-net='sudo systemctl restart netctl-auto@wlp1s0'
alias reload-fonts='fc-cache'
alias reload-xresources='xrdb -merge ~/.Xresources'


alias start='sudo systemctl start '
alias stop='sudo systemctl stop '
alias restart='sudo systemctl restart '
alias status='systemctl status '
