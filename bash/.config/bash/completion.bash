##
## Command completion stuff
##
shopt -s autocd                      # add cd to dir names to enter them
shopt -s cdspell                     # correct minor spelling errors when cd'ing
shopt -s dirspell                    # same as above, but with dirs

shopt -s progcomp                    # Programmable completion is FUN
shopt -s no_empty_cmd_completion

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

complete -cf sudo
complete -cf man
