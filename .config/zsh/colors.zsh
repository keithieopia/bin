#
# colors.zsh
#
# helper function to see if programs are installed
have() { command -v foo >/dev/null 2>&1 ; }

alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color'

have colordiff && alias diff='colordiff'
have pygmentize && alias cat='pygmentize -O style=monokai -f console256 -g '

[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

