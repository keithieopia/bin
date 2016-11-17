#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source files
source "$HOME/.config/bash/functions.bash" # must be first, some functions used below
source "$HOME/.config/bash/alias.bash"
source "$HOME/.config/bash/exports.bash"
source "$HOME/.config/bash/prompt.bash"


##
## Command completion stuff
##

if [ -f /usr/share/git/completion/git-completion.bash ]; then
  source /usr/share/git/completion/git-completion.bash
fi
complete -cf sudo
complete -cf man


##
## History
##

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'


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

# SSH agent
SSH_ENV="$HOME/.cache/ssh-env"

function start_agent {
     ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
}

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     if ! pgrep -u $USER ssh-agent > /dev/null; then
         start_agent
     fi
else
    start_agent
fi

# GPG agent
echo BYE | gpg-connect-agent &> /dev/null
GPG_TTY=$(tty)
export GPG_TTY


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
