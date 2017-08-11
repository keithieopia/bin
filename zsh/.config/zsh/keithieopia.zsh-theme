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
zsh_git_status() {
    INDEX=$(git status --porcelain 2> /dev/null)
    STATUS=""

    # Not-staged
    if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
        # Not-staged, Untracked
        STATUS="%{$R%}?$STATUS"
    fi
    
    if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
        # Not-staged, Unmerged
        STATUS="%{$R%}UU$STATUS"
    fi
    
    if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
        # Not-staged, Deleted
        STATUS="%{$R%}D$STATUS"
    fi
    
    # Modified
    if $(echo "$INDEX" | grep '^.M ' &> /dev/null); then
        STATUS="%{$R%}M$STATUS"
    elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
        STATUS="%{$R%}M$STATUS"
    elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
        STATUS="%{$R%}M$STATUS"
    fi
  
    # Staged
    if $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
        # Staged, Deleted
        STATUS="%{$G%}D$STATUS"
    fi
  
    if $(echo "$INDEX" | grep '^R' &> /dev/null); then
        # Staged, Renamed
        STATUS="%{$G%}R$STATUS"
    fi
  
    if $(echo "$INDEX" | grep '^M' &> /dev/null); then
        # Modified
        STATUS="%{$G%}M$STATUS"
    fi
  
    if $(echo "$INDEX" | grep '^A' &> /dev/null); then
        # Staged, Added 
        STATUS="%{$G%}A$STATUS"
    fi

    echo $STATUS
}

# get the name of the branch we are on (copied and modified from git.zsh)
zsh_git_prompt() {
    ZSH_THEME_GIT_PROMPT_PREFIX="%{$Y%}‹"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$Y%}›%{$RESET%} "

    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$(git_prompt_ahead)$(zsh_git_status)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

zsh_remote_host() {
    ZSH_THEME_HOST_PROMPT_PREFIX="%{$Y%}‹"
    ZSH_THEME_HOST_PROMPT_SUFFIX="%{$Y%}›%{$RESET%} "
    
    if [ "$SSH_CONNECTION" ]; then
        echo "$ZSH_THEME_HOST_PROMPT_PREFIX$(whoami)@$(hostname)$ZSH_THEME_HOST_PROMPT_SUFFIX" 
    else
        echo "" 
    fi
}


# %B sets bold text
PROMPT='$(zsh_remote_host) %B%2~%b $(zsh_git_prompt)$(zsh_usr_symbol)%{$RESET%} '

local return_code="%(?..%{$R%}%? ↵%{$RESET%})"
RPS1="${return_code}"



ZSH_THEME_GIT_PROMPT_DIRTY="%{$R%}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_AHEAD="%{$B%}➔"


