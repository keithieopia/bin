#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Determine if a program is installed, used in below aliases
have() { type "$1" &> /dev/null; }

ALIAS_DIR="$HOME/.config/bash"

# Load extras
load_dotfiles() {
    declare -a files=(
        $ALIAS_DIR/exports.bash
        $ALIAS_DIR/defaults.bash
        $ALIAS_DIR/arch.bash
        $ALIAS_DIR/colorize.bash
        $ALIAS_DIR/archive.bash
        $ALIAS_DIR/net.bash
        $ALIAS_DIR/prompt.bash
        $ALIAS_DIR/dir.bash
        $ALIAS_DIR/strings.bash
        $ALIAS_DIR/text.bash
        $ALIAS_DIR/exports.bash
        $ALIAS_DIR/completion.bash
        $ALIAS_DIR/misc.bash
    )

    # if these files are readable, source them
    for index in ${!files[*]}
    do
        if [[ -r ${files[$index]} ]]; then
            source ${files[$index]}
        fi
    done
}
load_dotfiles
unset load_dotfiles


##
## If root, set a timeout for the bash session
##
if [ `/usr/bin/id -u` -eq 0 ]; then
    TMOUT=600
fi

##
## Start ssh-agent if not running
##

SSH_ENV="$HOME/.cache/ssh-env"

function start_agent {
     ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
#     ssh-add
}

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     if ! pgrep -u $USER ssh-agent > /dev/null; then
         start_agent
     fi
else
    start_agent
fi
                                    


##
## PATH
##

# Include user's private bin if it exists
if [ -d ~/bin ]; then
    PATH=~/bin:"${PATH}"
fi

# Enable ccache for speedy compiling if possible
if [ -d /usr/lib/ccache/bin ] ; then
    PATH=/usr/lib/ccache/bin:"${PATH}"
fi


##
## Display QOTD 
##

# don't display quotes on tty1, because Xorg is set to autostart 
# on that term and fortune will cause a noticable delay

if have fortune && ! $(tty | grep -q tty1); then
    fortune -sa | colorize PURPLE
    echo # newline
fi


##
## PS1
##

# Set $PS1 (func in ~/dotfiles/alias.d/prompt.bash)
PROMPT_COMMAND=bash_prompt

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"


##
## Run on exit
##
trap_exit () {
    . "$HOME/.bash_logout"
}
