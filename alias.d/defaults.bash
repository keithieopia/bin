##
## Program Defaults
##

# safer commands
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

alias du='du -ch'
alias ls='ls --color=auto --group-directories-first'
alias dir='dir --color=auto'
alias mkdir='mkdir -p'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ps='ps auxf'
have shred && alias shred='shred -fuzvn 1'
have unclutter && alias unclutter='unclutter -idle 1 -root -grab -visible'
