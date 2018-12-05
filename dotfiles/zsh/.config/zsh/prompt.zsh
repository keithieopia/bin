# Sunrise theme for oh-my-zsh
# Intended to be used with Solarized: http://ethanschoonover.com/solarized

# Color shortcuts
R=$fg_no_bold[red]
G=$fg_no_bold[green]
M=$fg_no_bold[magenta]
Y=$fg_no_bold[yellow]
B=$fg_no_bold[blue]
RESET=$reset_color

zsh_usr_symbol() {
    if [ "$USER" = "root" ]; then
        PROMPTCOLOR="%{$R%}" 
        PROMPTSYMBOL="#"
    else
        PROMPTCOLOR="" 
        PROMPTSYMBOL="$"
    fi
    
    echo "$PROMPTCOLOR$PROMPTSYMBOL%{$RESET%}"
}

# Get the status of the working tree (copied and modified from git.zsh)
zsh_git_color() {
    INDEX=$(git status --porcelain 2> /dev/null | awk '{print $1}')
    COLOR=""

	if $(echo "$INDEX" | grep -q '??'); then
		# Magenta - Untracked files 
		COLOR="%{$M%}"
	fi	

	if $(echo "$INDEX" | grep -q M) || $(echo "$INDEX" | grep -q 'D'); then
		# Red - Modified / Deleted
		COLOR="%{$R%}"
	fi

	if $(echo "$INDEX" | grep -q A); then
		# Yellow - Added, but not committed files 
		COLOR="%{$Y%}"
	fi	

	if [[ $(echo $COLOR | wc -c) -lt 6 ]]; then
		# no untracked, added, modified, or deleted files
		# e.g.: no local changes
		
		if $(git status -sb | grep -q ahead); then
			# Green - We're ahead of the master
			COLOR="%{$G%}"
		fi
	fi

    echo $COLOR    
}

# get the name of the branch we are on (copied and modified from git.zsh)
zsh_git_prompt() {
	if $(git rev-parse --is-inside-work-tree 2>/dev/null | grep -q true); then
		echo -n "‹$(zsh_git_color)" 
		
		if [[ $(git branch | wc -c) -ne 0 ]]; then
			echo -n $(git branch | awk '{print $2}')
		else
			echo -n "master"
		fi
		
		echo "%{$RESET%}› "
	fi
}

zsh_remote_host() {
    ZSH_THEME_HOST_PROMPT_PREFIX="%{$Y%}‹"
    ZSH_THEME_HOST_PROMPT_SUFFIX="%{$Y%}›%{$RESET%} "

    if [ "$SSH_CONNECTION" ]; then
        echo "$ZSH_THEME_HOST_PROMPT_PREFIX$(whoami)@$(hostname)$ZSH_THEME_HOST_PROMPT_SUFFIX"
    else
        echo " "
    fi
}


# %B sets bold text
PROMPT='$(zsh_remote_host)%B%2~%b $(zsh_git_prompt)$(zsh_usr_symbol)%{$RESET%} '

local return_code="%(?..%{$R%}%? ↵%{$RESET%})"
RPS1="${return_code}"



ZSH_THEME_GIT_PROMPT_DIRTY="%{$R%}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_AHEAD="%{$B%}➔"
