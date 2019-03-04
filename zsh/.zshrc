# run before loading oh-my-zsh compleat
# https://github.com/robbyrussell/oh-my-zsh/issues/3234
autoload -Uz compinit
compinit

# antigen & oh-my-zsh plugin manager
source ~/.config/zsh/antigen.zsh  # must be first
antigen use oh-my-zsh             # must be second
antigen bundle git
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle pass
antigen bundle docker
antigen bundle pip
antigen bundle sudo
antigen bundle ufw
antigen bundle yarn
antigen bundle compleat          # fyi this is not a misspelled
antigen bundle wd
antigen bundle apply             # must be last

# reset frozen terminals by misbehaving applications
ttyctl -f

# typing a dir's name, cd's into it
setopt auto_cd cdable_vars

# history settings
setopt histignorealldups sharehistory
HISTSIZE=50
SAVEHIST=50
HISTFILE=~/.bash_history

# Aliases & Functions
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
	# Run the following if not in SSH

	# Set the color scheme
	~/.config/zsh/base16/base16-solarized-dark.sh

    # if we're *not* in a virtual terminal...
	if ! tty | grep -q /dev/pts; then

	    # and we have tmux and it's not running, start it
	    if type tmux > /dev/null && [ -z "$TMUX" ]; then
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
