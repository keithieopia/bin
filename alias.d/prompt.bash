bash_prompt () {
    local WHITE="\[\033[0;37m\]"
    local BLACK="\[\033[1;30m\]"
    local RED="\[\033[0;31m\]"
    local YELLOW="\[\033[0;33m\]"
    local GREEN="\[\033[0;32m\]"
    local BLUE="\[\033[0;34m\]"
    local RESET="\[\033[0m\]"

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

    local PWDCOLOR=$BLACK
    local USRSYMBOL="\$"

    if is_root; then
        local PWDCOLOR=$RED
        local USRSYMBOL="#"
    fi

    if is_ssh; then
        local HOST="$BLUE[ $WHITE\h $BLUE] "
    fi

    local GIT="$(prompt_git)"

    export PS1="$TITLEBAR$HOST$BLUE[ $PWDCOLOR$NEW_PWD$GIT $BLUE]$WHITE$USRSYMBOL$RESET "
    export PS2='> '
    export PS4='+ '
}

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

            # c
            if `git status | grep ahead > /dev/null`; then
                local SYMBOL="${SYMBOL}${YELLOW}↺"
            fi
            
            #  uncommitted changes
            if ! $(git diff --quiet --ignore-submodules --cached); then
                local SYMBOL="${SYMBOL}${YELLOW}+"
            fi

            # unstaged changes
            if ! $(git diff-files --quiet --ignore-submodules --); then
                local SYMBOL="${SYMBOL}${RED}!"
            fi

            # untracked files
            if [ -n "$(git ls-files --others --exclude-standard)" ]; then
                local SYMBOL="${SYMBOL}${RED}?"
            fi
        
            #
            if [[ -z "$SYMBOL" ]]; then
                local SYMBOL="${SYMBOL}${GREEN}✓"
            fi

            echo " $BLACK($SYMBOL$BLACK)$RESET"
        fi
    fi
}

is_ssh () {
    if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
        return 0
    else
        return 1
    fi
}

is_root () {
    PRIV=1
    if [ `/usr/bin/id -u` -eq 0 ]; then
        PRIV=0
    fi
    return $PRIV
}
