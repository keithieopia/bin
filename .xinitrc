xmodmap ~/.Xmodmap

(sleep 30s; (while true; do $HOME/bin/gen-wallpaper; sleep 3600; done)) &

exec /usr/local/bin/startxfce4 --with-ck-launch
