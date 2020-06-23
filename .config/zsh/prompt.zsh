# Sunrise theme for oh-my-zsh
# Intended to be used with Solarized: http://ethanschoonover.com/solarized

zsh_usr_symbol() {
    if [ "$USER" = "root" ]; then
		echo "%{%F{red}%}#%{%f%}"
    else
		echo "$"
    fi
}

# Get the status of the working tree (copied and modified from git.zsh)
zsh_git() {
	if git -C $PWD rev-parse --is-inside-work-tree 2>/dev/null | grep -q true; then

		BRANCH="$(git -C $PWD branch --no-color | grep '*' | sed 's/* //g')"
		INDEX=$(git status --porcelain 2> /dev/null | awk '{print $1}')
		COLOR="%{%F{blue}%}"

		if $(echo "$INDEX" | grep -q '??'); then # Untracked files
			COLOR="%{%F{magenta}%}"
		fi

		if $(echo "$INDEX" | grep -q M) || $(echo "$INDEX" | grep -q 'D'); then # Modified / Deleted
			COLOR="%{%F{red}%}"
		fi

		if $(echo "$INDEX" | grep -q A); then # Added, but not committed files
			COLOR="%{%F{yellow}%}"
		fi

		if $(git status -sb | grep -q ahead); then # We're ahead of the master
			COLOR="%{%F{green}%}"
		fi

		echo "${COLOR}${BRANCH}%{%f%}"
	fi
}

zsh_remote_host() {
    if [ "$SSH_CONNECTION" ]; then
		echo -n "%{%F{yellow}%}"
		echo -n "$(whoami)@$(hostname)"
        echo "%{%f%}"
    fi
}

preexec() {
	# this is to prevent non-zero exit statuses from sticking past multiple successful commands
	preexec_called=1
}

precmd() {
	EXIT_STATUS=$?
	if [ "$EXIT_STATUS" != 0 ] && [ "$preexec_called" = 1 ]; then
		RPS1="%{%F{red}%}$EXIT_STATUS X%{%f%} "
		unset preexec_called
	else
		RPS1=""
	fi

	# This is needed so that the git branch shown is $PWD
	# and not the previous dir. precmd() is a zsh built-in
	# that runs before the prompt is set
	RPS1="$RPS1$(zsh_git)"
}

show_prompt() {
	export PROMPT="$(zsh_remote_host) %{%B%}%2~%{%b%} $(zsh_usr_symbol) "
}