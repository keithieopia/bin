##
## Export and general options
##

## Bash Options
shopt -s extglob       # necessary for programmable completion
shopt -s nocaseglob    # Case-insensitive globbing
shopt -s progcomp      # Programmable completion is FUN
shopt -s checkwinsize  # update values of LINES and COLUMNS
shopt -s cdspell       # correct minor spelling errors when cd'ing
shopt -s cmdhist       # collapse multi-line commands to one line
shopt -s checkhash     # check cache before finding full path
shopt -s no_empty_cmd_completion
shopt -s histappend histreedit histverify

# No beep... WHY IS THIS NOT THE DEFAULT!?
set bell-style visible 

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


# History
export HISTSIZE=60
export HISTIGNORE="*history*:ls:df*:cd*:pwd:su:clear:exit:rm*:shred*"
export HISTCONTROL="ignoreboth"
export HISTTIMEFORMAT="%F %T "


## Default Programs
export EDITOR=/usr/bin/nano
export VISUAL=$EDITOR

# Default X11 programs
if [ "$DISPLAY" ]; then
    export BROWSER="firefox "
    export WINEARCH=win32
fi

# Pager
if have less; then
    export PAGER='less'
    unset LESSCHARSET # Fix manpages looking funky
    export LESS='--ignore-case --line-numbers --hilite-unread  -z-4 --hilite-search --LONG-PROMPT --no-init --quit-if-one-screen --quit-on-intr --RAW-CONTROL-CHARS'
elif have most; then
    export PAGER='most'
else
    export PAGER='more'
fi
