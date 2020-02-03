# update dotfiles automatically
if [ -f "${HOME}/.config/zsh/dotfiles-autoupdate.zsh" ]; then
	source "${HOME}/.config/zsh/dotfiles-autoupdate.zsh"
fi

# fix for slow git completion
# must come before loading plugins
__git_files () {
    _wanted files expl 'local files' _files
}

# run before loading oh-my-zsh compleat
# https://github.com/robbyrussell/oh-my-zsh/issues/3234
autoload -Uz compinit
compinit

# clone zgen if not present
if [ ! -d "${HOME}/.zgen" ]; then
	git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

# sanity check for above failing:
# source zgen only if it exists
if [ -f "${HOME}/.zgen/zgen.zsh" ]; then
	source "${HOME}/.zgen/zgen.zsh"

	if ! zgen saved; then
		# specify plugins here
		zgen oh-my-zsh
		zgen oh-my-zsh plugins/git
		zgen oh-my-zsh plugins/sudo
		zgen oh-my-zsh plugins/command-not-found
		zgen oh-my-zsh plugins/pass
		zgen oh-my-zsh plugins/compleat
		zgen oh-my-zsh plugins/yarn
		zgen oh-my-zsh plugins/wd
		zgen load supercrabtree/k

		# Linux only plugins
		if uname | grep -s Linux >/dev/null; then
			zgen oh-my-zsh plugins/ufw
		fi

		# generate the init script from plugins above
		zgen save
	fi
fi

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
source ~/.config/zsh/find-missing-cmds.zsh
source ~/.config/zsh/functions.zsh

if [ -f "${HOME}/.bash_aliases" ]; then
	source "${HOME}/.bash_aliases"
fi

if [ -f "${HOME}/.bash_functions" ]; then
	source "${HOME}/.bash_functions"
fi

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

# set npm path
if [ -d ~/.npm-packages ]; then
	export NPM_PACKAGES="$HOME/.npm-packages"
	export PATH=$NPM_PACKAGES/bin:"${PATH}"
	unset MANPATH
	MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
	export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
fi

if type ccache > /dev/null; then
    export PATH="/usr/lib/ccache/bin/:$PATH"
fi

case "$TERM" in
    xterm*) TERM=xterm-256color
esac


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
