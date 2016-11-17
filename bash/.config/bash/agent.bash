##
## SSH & GPG Agents
##


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
