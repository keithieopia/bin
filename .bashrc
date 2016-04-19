#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ "$DISPLAY" ]; then
    export EDITOR=/usr/bin/geany
    export SUDO_ASKPASS=/usr/bin/gksudo
    export BROWSER="firefox"
else
    export EDITOR=/usr/bin/nano
fi

export VISUAL=$EDITOR

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GREP_COLOR="1;33"

export WINEARCH=win32

# update values of LINES and COLUMNS
shopt -s checkwinsize

# correct minor spelling errors when cd'ing
shopt -s cdspell

# No beep... WHY IS THIS NOT THE DEFAULT!?
set bell-style visible


##
## Command History Stuff
##
export HISTSIZE=2000
export HISTIGNORE=*history*:ls*:df*:cd*:pwd:su:clear:exit:gpg*:shred*
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT='%F %T '
shopt -s histappend

# bash history is only saved when close terminal, not after each command and this fixes it
shopt -s histappend
if [ -n "$PROMPT_COMMAND" ]; then
    PROMPT_COMMAND="$PROMPT_COMMAND; history -a"
else
    PROMPT_COMMAND='history -a'
fi


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

if type most >/dev/null 2>&1 ; then
  # does not need LESS_TERMCAP_*
  PAGER=most
  export PAGER
else
  export LESS='-R'
  export LESSOPEN='|~/.lessfilter %s'
fi


##
## Command completion stuff
##

shopt -s extglob # needed for bash completion (programmable completion)

# Bash Completion
if [ -f /usr/share/git/completion/git-completion.bash ]; then
  source /usr/share/git/completion/git-completion.bash
fi
complete -cf sudo
complete -cf man


##
## Alias
##

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

##
## Colors
## usage: echo "something" | colorize COLORNAME
##
source ~/bin/colorize

##
## PS1
##

# QOTD
echo -e "\e[00;33m$(fortune -sa)\e[00m\n"

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

    # Root PS1
    if [ "$(id -u)" == "0" ]; then
        export PS1="$TITLEBAR$BLUE[ $RED$NEW_PWD$BLUE ] $WHITE#$NO_COLOR "

    # User PS1
    else
        # Set $__git_ps1
        if [ -f /usr/share/git/completion/git-prompt.sh ]; then
            source /usr/share/git/completion/git-prompt.sh
        fi

        # if we're in a Git repo, show current branch
        if [ "\$(type -t __git_ps1)" ]; then
            BRANCH="\$(__git_ps1 '[ %s ] ')"
        fi

        export PS1="$TITLEBAR$BLUE[ $BOLD_BLACK$NEW_PWD$BLUE ]$BRANCH$WHITE\$$NO_COLOR "
    fi

    export PS2='> '
    export PS4='+ '
}
PROMPT_COMMAND=prompt_command
unset bash_prompt


# Format time to my liking
format_time () {
    if [ `date +%p` = "PM" ]; then
        meridiem="pm"
    else
        meridiem="am"
    fi
    date +"%l:%M:%S$meridiem"|sed 's/ //g'
}

trap_exit () {
    . "$HOME/.bash_logout"
}
