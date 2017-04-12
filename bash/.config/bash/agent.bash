##
## SSH & GPG Agents
##


# Run GPG agent only on home computer
if [ $(hostname) == 'toshy' ]; then

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

fi
