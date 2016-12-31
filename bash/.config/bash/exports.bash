##
## Export and general options
##

# Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Colors
export GREP_COLOR="1;33"
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


## 
## Default Programs
##
export EDITOR=/usr/bin/nano
export VISUAL=$EDITOR

# Xorg programs
if [ "$DISPLAY" ]; then
    export BROWSER=palemoon
    #export WINEARCH=win32
fi

# Pager
if have less; then
    export PAGER='less'
    unset LESSCHARSET # Fix manpages looking funky
    export LESS='--ignore-case --line-numbers --hilite-unread  -z-4 --hilite-search --LONG-PROMPT --no-init --quit-if-one-screen --quit-on-intr --RAW-CONTROL-CHARS'
else
    export PAGER='more'
fi
