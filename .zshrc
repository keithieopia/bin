# update dotfiles automatically
if [ -f "${HOME}/.config/zsh/dotfiles-autoupdate.zsh" ]; then
	source "${HOME}/.config/zsh/dotfiles-autoupdate.zsh"
fi

ZGEN_RESET_ON_CHANGE=(${HOME}/.zshrc)

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
[ ! -d "${HOME}/.zgen" ] && git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"


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
		zgen oh-my-zsh plugins/dotenv
		zgen oh-my-zsh plugins/gitfast
		zgen oh-my-zsh plugins/git
		zgen oh-my-zsh plugins/z
		zgen oh-my-zsh plugins/ufw
		zgen oh-my-zsh plugins/dirhistory
		zgen load MichaelAquilina/zsh-you-should-use
		zgen load supercrabtree/k
		zgen load zlsun/solarized-man
		zgen load psprint/zsh-morpho
		zgen load $HOME/.config/zsh/colors.zsh
		zgen load $HOME/.config/zsh/alias.zsh
		zgen load $HOME/.config/zsh/find-missing-cmds.zsh
		zgen load $HOME/.config/zsh/functions.zsh
		zgen load $HOME/.config/zsh/remind.zsh
		zgen load $HOME/.config/zsh/fortune.zsh
		zgen load $HOME/.config/zsh/prompt.zsh
		# generate the init script from plugins above
		zgen save
	fi
fi

# screensaver (zsh-morpho)
if tty | grep -q /dev/tty; then
	if hash cmatrix 2>/dev/null; then
		zstyle ":morpho" screen-saver "cmatrix" # select screen saver "zmorpho"; available: zmorpho, zmandelbrot, zblank, pmorpho
	fi
	
	zstyle ":morpho" arguments "-s"         # arguments given to screen saver program; -s - every key press ends
	zstyle ":morpho" delay "300"            # 5 minutes before screen saver starts
	zstyle ":morpho" check-interval "60"    # check every 1 minute if to run screen saver
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

# set default editor
export EDITOR=nvim

case "$TERM" in
    xterm*) TERM=xterm-256color
esac


# auto ls when cd'ing
chpwd() { ls }

# output only if we're in a virtual terminal
if tty | grep -q /dev/pts; then
	show_remind
	show_fortune
fi

show_prompt
