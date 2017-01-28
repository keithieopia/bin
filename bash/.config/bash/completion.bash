##
## Command completion stuff
##
shopt -s autocd                      # add cd to dir names to enter them
shopt -s cdspell                     # correct minor spelling errors when cd'ing
shopt -s dirspell                    # same as above, but with dirs

shopt -s progcomp                    # Programmable completion is FUN
shopt -s no_empty_cmd_completion

if [ -f /usr/share/git/completion/git-completion.bash ]; then
  source /usr/share/git/completion/git-completion.bash
fi

complete -cf sudo
complete -cf man
