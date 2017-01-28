#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return


# Bash Options
shopt -s extglob                         # necessary for programmable completion
shopt -s nocaseglob                      # Case-insensitive globbing
shopt -s checkwinsize                    # update values of LINES and COLUMNS
shopt -s checkhash                       # check cache before finding full path
bind "set mark-symlinked-directories on" # add slash to syslink dirs
bind "set bell-style visible"            # no beep


# Source files (comments denote dependencies that have to come before it)
source "$HOME/.config/bash/functions.bash"
source "$HOME/.config/bash/alias.bash"      # needs functions.bash
source "$HOME/.config/bash/exports.bash"    # needs functions.bash
source "$HOME/.config/bash/completion.bash"
source "$HOME/.config/bash/agent.bash"
source "$HOME/.config/bash/prompt.bash"
source "$HOME/.config/bash/history.bash"    # needs prompt.bash


##
## Security
##

# If root, set a timeout for the bash session
if [ `/usr/bin/id -u` -eq 0 ]; then
    TMOUT=600
fi

# secret vars (api keys)
if [ -f ~/.bash_secrets ]; then
    source ~/.bash_secrets
fi


##
## PATH
##

# Include user's private bin if it exists
if [ -d ~/bin ]; then
    PATH=~/bin:"${PATH}"
fi

# ccache pre-processor for C/C++
if have ccache; then
    PATH="/usr/lib/ccache/bin:$PATH"
fi


##
## Display QOTD 
##

# don't display quotes on tty1, because Xorg is set to autostart 
# on that term and fortune will cause a noticable delay

if have fortune && ! $(tty | grep -q tty1); then
    echo -e "\033[0;35m$(fortune -sa)\033[0m\n"
fi


##
## Run on exit
##
trap_exit () {
    . "$HOME/.bash_logout"
}
