source ~/.config/zsh/antigen.zsh
antigen use oh-my-zsh

antigen bundle git
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle pass
antigen bundle ssh-agent
antigen bundle docker
antigen bundle pip
antigen bundle sudo
antigen bundle ufw

antigen bundle apply

# reset frozen terminals by misbehaving applications
ttyctl -f

# history settings
setopt histignorealldups sharehistory
HISTSIZE=50
SAVEHIST=50
HISTFILE=~/.bash_history

# rehash automatically on path changes
zstyle ':completion:*' rehash true

# Use modern completion system
autoload -Uz compinit
compinit 2&>/dev/null # TODO: fix compaudit 150 error, whatever that means

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

source ~/.config/zsh/alias.zsh
source ~/.config/zsh/functions.zsh

# set default editor
export EDITOR=nvim

# add sbin to path
export PATH=/sbin:"${PATH}"

# Include user's private bin if it exists
if [ -d ~/bin ]; then
    export PATH=~/bin:"${PATH}"
fi

# Include pip install path
if [ -d ~/.local/bin ]; then
    export PATH=~/.local/bin:"${PATH}"
fi

# set go path
if [ -d ~/.go ]; then
    export GOPATH=$HOME/.go
    export PATH=$GOROOT/bin:"${PATH}"
fi

if type ccache > /dev/null; then
    export PATH="/usr/lib/ccache/bin/:$PATH"
fi

case "$TERM" in
    xterm*) TERM=xterm-256color
esac


if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	# If running inside ssh, do nothing
else
	#
	# Run the following if not in SSH
	#
	
	# Set the color scheme
	~/.config/zsh/base16/base16-solarized-dark.sh
	
	# if we have tmux, and it's not running, start it
	if type tmux > /dev/null; then
		if [ -z "$TMUX" ]; then
			tmux
			
			# exit zsh when we exit tmux
			exit
		fi
	fi
fi

#
# output only if we're in a virtual terminal 
#
if tty | grep -q /dev/pts; then
	if [ -f "~/.config/zsh/remind.zsh" ]; then
		source ~/.config/zsh/remind.zsh
	fi

	source ~/.config/zsh/fortune.zsh
	echo
fi

source ~/.config/zsh/prompt.zsh