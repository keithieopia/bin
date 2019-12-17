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
	if git rev-parse --is-inside-work-tree 2>/dev/null | grep -q true; then

		BRANCH="$(git branch | awk '{print $2}' | xargs)"
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

   		echo -n "$COLOR"
   		echo -n "$BRANCH"
   		echo "%{%f%}"
	fi
}

zsh_remote_host() {
    if [ "$SSH_CONNECTION" ]; then
    	echo -n "%{%F{yellow}%}"
		echo -n "$(whoami)@$(hostname)"
        echo "%{%f%}"
    fi
}

export PROMPT="$(zsh_remote_host) %{%B%}%2~%{%b%} $(zsh_usr_symbol) "
export RPS1="%(?..%{$R%}%? ↵%{$RESET%}) $(zsh_git)"
