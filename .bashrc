#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# No beep... WHY IS THIS NOT THE DEFAULT!?
set bell-style visible 

##
## Functions
##

# Alias and functions in this file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Colors ( usage: echo "something" | colorize COLORNAME )
if [ -f ~/bin/colorize ]; then
    . ~/bin/colorize
fi


##
## If root, set a timeout for the bash session
##
if is_root; then
    TMOUT=600
fi


##
## Default programs
##

if [ "$DISPLAY" ]; then
    export BROWSER="firefox "
fi

export EDITOR=/usr/bin/nano
export VISUAL=$EDITOR

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GREP_COLOR="1;33"

export WINEARCH=win32


##
## History options
##

# bash history is only saved when close terminal, not after each command and this fixes it
if [ -n "$PROMPT_COMMAND" ]; then
    PROMPT_COMMAND="$PROMPT_COMMAND; history -a"
else
    PROMPT_COMMAND='history -a'
fi

export HISTSIZE=30
export HISTIGNORE="*history*:ls*:df*:cd*:pwd:su:clear:exit:rm*:shred*"
export HISTCONTROL="ignoreboth"
export HISTTIMEFORMAT="%F %T "
shopt -s histappend histreedit histverify

##
## Default options
##
shopt -s extglob       # necessary for programmable completion
shopt -s nocaseglob    # Case-insensitive globbing
shopt -s progcomp      # Programmable completion is FUN
shopt -s checkwinsize  # update values of LINES and COLUMNS
shopt -s cdspell       # correct minor spelling errors when cd'ing
shopt -s cmdhist       # collapse multi-line commands to one line
shopt -s checkhash     # check cache before finding full path
shopt -s no_empty_cmd_completion

##
## PATH
##

# Include user's private bin if it exists
if [ -d ~/bin ]; then
    PATH=~/bin:"${PATH}"
fi

if [ -d ~/.gem/ruby/2.3.0/bin ]; then
    PATH=~/.gem/ruby/2.3.0/bin:"${PATH}"
fi

# Enable ccache for speedy compiling if possible
if [ -d /usr/lib/ccache/bin ] ; then
    PATH=/usr/lib/ccache/bin:"${PATH}"
fi


##
## PAGER / LESS
##

if have less; then
    export PAGER='less'
    unset LESSCHARSET # Fix manpages looking funky
    export LESS='--ignore-case --line-numbers --hilite-unread  -z-4 --hilite-search --LONG-PROMPT --no-init --quit-if-one-screen --quit-on-intr --RAW-CONTROL-CHARS'

    # Colorized less
    export LESS_TERMCAP_mb=$'\E[01;31m'
    export LESS_TERMCAP_md=$'\E[01;31m'
    export LESS_TERMCAP_me=$'\E[0m'
    export LESS_TERMCAP_se=$'\E[0m'
    export LESS_TERMCAP_so=$'\E[01;44;33m'
    export LESS_TERMCAP_ue=$'\E[0m'
    export LESS_TERMCAP_us=$'\E[01;32m'
elif have most; then
    export PAGER='most'
else
    export PAGER='more'
fi


##
## Command completion stuff
##

if [ -f /usr/share/git/completion/git-completion.bash ]; then
  source /usr/share/git/completion/git-completion.bash
fi
complete -cf sudo
complete -cf man


##
## PS1
##

# QOTD
have fortune && echo -e "$(fortune -sa)\n" | colorize PURPLE


prompt_command () {

    # regular colors
    local BLACK="\[\033[0;30m\]"
    local RED="\[\033[0;31m\]"
    local GREEN="\[\033[0;32m\]"
    local YELLOW="\[\033[0;33m\]"
    local BLUE="\[\033[0;34m\]"
    local MAGENTA="\[\033[0;35m\]"
    local CYAN="\[\033[0;36m\]"
    local WHITE="\[\033[0;37m\]"

    # emphasized (bolded) colors
    local BOLD_BLACK="\[\033[1;30m\]"
    local BOLD_RED="\[\033[1;31m\]"
    local BOLD_GREEN="\[\033[1;32m\]"
    local BOLD_YELLOW="\[\033[1;33m\]"
    local BOLD_BLUE="\[\033[1;34m\]"
    local BOLD_MAGENTA="\[\033[1;35m\]"
    local BOLD_CYAN="\[\033[1;36m\]"
    local BOLD_WHITE="\[\033[1;37m\]"

    # background colors
    local BG_BLACK="\[\033[40m\]"
    local BG_RED="\[\033[41m\]"
    local BG_GREEN="\[\033[42m\]"
    local BG_YELLOW="\[\033[43m\]"
    local BG_BLUE="\[\033[44m\]"
    local BG_MAGENTA="\[\033[45m\]"
    local BG_CYAN="\[\033[46m\]"
    local BGW_HITE="\[\033[47m\]"

    # other
    local RESET="\[\017\]"
    local NO_COLOR="\[\033[0m\]"

    # PWD
    PROMPT_DIRTRIM=3
    local NEW_PWD=${PWD/#$HOME/\~}

    # title bar
    case $TERM in
        xterm*)
            local TITLEBAR='\[\033]0;\u@\h:\w\007\]'
            ;;
        *)
            local TITLEBAR=""
            ;;
    esac

    local PWDCOLOR=$BOLD_BLACK
    local USRSYMBOL="\$"

    if is_root; then
        local PWDCOLOR=$RED
        local USRSYMBOL="#"
    fi

    if is_ssh; then
        local HOST="$BLUE[ $WHITE\h $BLUE] "
    fi

    local GIT="$(prompt_git)"

    export PS1="$TITLEBAR$HOST$BLUE[ $PWDCOLOR$NEW_PWD$GIT $BLUE]$WHITE$USRSYMBOL$NO_COLOR "
    export PS2='> '
    export PS4='+ '
}
PROMPT_COMMAND=prompt_command
unset bash_prompt

##
## $PS1 prompt functions
##

prompt_git() {
    local SYMBOL=""

    # check if the current directory is in a git repository
    if [ $(git rev-parse --is-inside-work-tree &>/dev/null; printf "%s" $?) == 0 ]; then

        # check if the current directory is in .git before running git checks
        if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == "false" ]; then
            local SYMBOL=""

            # ensure index is up to date
            git update-index --really-refresh  -q &>/dev/null

            # check for uncommitted changes in the index
            if ! $(git diff --quiet --ignore-submodules --cached); then
                local SYMBOL="${SYMBOL}${GREEN}+"
            fi

            # check for unstaged changes
            if ! $(git diff-files --quiet --ignore-submodules --); then
                local SYMBOL="${SYMBOL}${RED}!"
            fi

            # check for untracked files
            if [ -n "$(git ls-files --others --exclude-standard)" ]; then
                local SYMBOL="${SYMBOL}${RED}?"
            fi

            if [[ -z "$SYMBOL" ]]; then
                local SYMBOL="${SYMBOL}${BLUE}*"
            fi

            echo " $BOLD_BLACK($SYMBOL$BOLD_BLACK)"
        fi
    fi
}

##
## Nethack
##
if have nethack; then
    if [ -f ~/.nethackrc ]; then
        export NETHACKOPTIONS="@${HOME}/.nethackrc"
    else
        export NETHACKOPTIONS="!autopickup,number_pad:1,color" # Set some but not all of my options, if I don't have a dedicated file
    fi
fi

# Run on exit
trap_exit () {
    . "$HOME/.bash_logout"
}
