if hash fortune 2>/dev/null; then
    print -P '%F{blue}$(fortune -as)%f\n'
fi