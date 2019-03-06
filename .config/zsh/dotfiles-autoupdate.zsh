UPDATE_AFTER=86400 # 1 day in seconds
TIME=$(date +%s)

# normal git repo
#LAST_FETCH=$(stat -c %Y "$HOME/dotfiles/.git/FETCH_HEAD")

# bare git repo
LAST_FETCH=$(stat -c %Y "$HOME/.dotfiles/refs/heads/master")

if ((TIME - LAST_FETCH >= UPDATE_AFTER)); then
  # run in a subshell to avoid changing our current working dir
  (cd $HOME/dotfiles && git pull) > /dev/null
fi
