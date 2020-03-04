# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# add sbin to path
export PATH="/sbin:$PATH"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set go path
if [ -d $HOME/.go ]; then
    export GOPATH=$HOME/.go
    export PATH="$GOROOT/bin:$PATH"
fi

# set npm path
if [ -d $HOME/.npm-packages ]; then
	export NPM_PACKAGES="$HOME/.npm-packages"
	export PATH=$NPM_PACKAGES/bin:"${PATH}"
	unset MANPATH
	MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
	export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
fi

if type ccache > /dev/null; then
    export PATH="/usr/lib/ccache/bin/:$PATH"
fi

_byobu_sourced=1 . /usr/bin/byobu-launch 2>/dev/null || true
