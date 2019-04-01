UPDATE_AFTER=86400 # 1 day in seconds
TIME=$(date +%s)

# normal git repo
LAST_FETCH=$(stat -f %m "$HOME/.git/FETCH_HEAD")

if ((TIME - LAST_FETCH >= UPDATE_AFTER)); then
  # run in a subshell to avoid changing our current working dir
  (cd $HOME && git pull) > /dev/null
fi
