#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Determine if a program is installed, used in below aliases
have() { type "$1" &> /dev/null; }

# Load extras
load_dotfiles() {
    declare -a files=(
        $HOME/dotfiles/alias.d/exports.bash
        $HOME/dotfiles/alias.d/defaults.bash
        $HOME/dotfiles/alias.d/arch.bash
        $HOME/dotfiles/alias.d/colorize.bash
        $HOME/dotfiles/alias.d/archive.bash
        $HOME/dotfiles/alias.d/net.bash
        $HOME/dotfiles/alias.d/prompt.bash
        $HOME/dotfiles/alias.d/dir.bash
        $HOME/dotfiles/alias.d/strings.bash
        $HOME/dotfiles/alias.d/text.bash
        $HOME/dotfiles/alias.d/exports.bash
        $HOME/dotfiles/alias.d/completion.bash
        $HOME/dotfiles/alias.d/misc.bash
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
## PS1
##

# QOTD
have fortune && echo -e "$(fortune -sa)\n" | colorize PURPLE

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
