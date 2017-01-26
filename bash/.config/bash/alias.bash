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
have shred && alias shred='shred -fuzvn 1'
have unclutter && alias unclutter='unclutter -idle 1 -root -grab -visible'

# replace built-ins with better programs if we have them
have dcfldd && alias dd='dcfldd'
have htop && alias top='htop'
have colordiff && alias diff='colordiff'
have pydf && alias df='pydf'

# new commands
alias ..="cd .."
alias ~='cd ~ && clear'
alias trash="mv -t ~/.local/share/Trash/files --backup=t"


alias epoch='date +%s'
alias fuck='sudo $(history -p !!)' # some people are nice and instead call this "please"
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias copy='rsync -ah --progress' # cp with progress indicator
alias lsd='ls -l | grep "^d"' # list only dirs
alias ll='ls -lhA --color | less -R'
alias ports='sudo lsof -i -n -P' # list open ports / running network services
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e' # like pgrep, but better

# Websites
alias google="firefox -P Browsing http://www.google.com"
alias wiki="firefox -P Browsing http://en.wikipedia.org/wiki/Main_Page"

# Security
alias firefox="firejail --whitelist=~/projects/startpage firefox"

# sudo
alias snano='sudo nano'
alias ufw='sudo ufw'

# reload
alias reload-bash='source ~/.bashrc'
alias reload-alias='source ~/.config/bash/alias.bash'
alias reload-net='sudo systemctl reload netctl-auto@wlp1s0'
alias reload-fonts='fc-cache'
alias reload-xresources='xrdb -merge ~/.Xresources'
