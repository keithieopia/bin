##
## Source .bashrc if it exists
##

[[ -f ~/.bashrc ]] && . ~/.bashrc

##
## Start SSH agent if not currently running
##


SSH_ENV="$HOME/.ssh/env"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    /usr/bin/ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi


##
## Start X on login if we're on TTY 1 (the default TTY)
##

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
