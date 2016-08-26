##
## Command completion stuff
##

if [ -f /usr/share/git/completion/git-completion.bash ]; then
  source /usr/share/git/completion/git-completion.bash
fi
complete -cf sudo
complete -cf man

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
