##
## SSH & GPG Agents
##


## SSH agent
#SSH_ENV="$HOME/.cache/ssh-env"

#function start_agent {
#     ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
#     chmod 600 "${SSH_ENV}"
#     . "${SSH_ENV}" > /dev/null
#}
#
#if [ -f "${SSH_ENV}" ]; then
#     . "${SSH_ENV}" > /dev/null
#     if ! pgrep -u $USER ssh-agent > /dev/null; then
#         start_agent
#     fi
#else
#    start_agent
#fi

# GPG agent
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
    gpg-connect-agent /bye >/dev/null 2>&1
fi

export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi
