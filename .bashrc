# ~/.bashrc

# don't run if the shell not interactive
[ -z "$PS1" ] && return

if hash zsh 2>/dev/null; then
	if [[ "$SHELL" != "$(which zsh)" ]]; then
		echo "changing ${USER}'s shell to zsh then switching over..."
		chsh -s $(which zsh)

		if [ $? -eq 0 ]; then
			zsh && exit
		fi
	else
		echo "switching over to zsh..."
		zsh && exit
	fi
fi