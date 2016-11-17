##
## History
##
shopt -s cmdhist       # save multi-line commands as one line in history
shopt -s histappend    # append to history, don't overwrite
shopt -s histappend histreedit histverify

export HISTSIZE=60
export HISTIGNORE="*history*:ls:df*:pwd:su:clear:exit:rm*:shred*"
export HISTCONTROL="ignoreboth"
export HISTTIMEFORMAT="%F %T "

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Up and down arrow history searching
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'
