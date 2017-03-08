#!/bin/sh

function usage() {
cat <<HELP
Take a picture of yourself using the webcam

Usage: $(basename "$0") [FILE]
    -q : don't open the picture afterwards

Note:
    By default the picture is saved as 'webcam-YYYY-MM-DD-HH:MM:SS.jpg' in
    $XDG_PICTURES_DIR. If XDG isn't installed, the directory defaults to $HOME


https://github.com/keithieopia/bin/

Copyright (c) 2017 Timothy Keith
Licensed under the MIT license.
HELP
}


QUIET=0

while getopts ":hq" opt; do
    case $opt in
        h)
            usage
            exit
            ;;
        q)
            QUIET=1
            ;;
        *)
            usage
            exit 1
            ;;
    esac
    shift $((OPTIND-1))
done

if ! hash ffmpeg 2>/dev/null; then
    echo "ffmpeg is not installed!"
    exit 1
fi

if hash xdg-user-dir 2>/dev/null; then
    DIR="$(xdg-user-dir PICTURES)"
else
    # showing the picture requires XDG so if not installed
    # override with -q
    QUIET=1 
    DIR="$HOME"
fi

if [ -z ${1+x} ]; then
    FILE="webcam-$(date +'%F-%T').jpg"
else
    FILE="$1"
fi


# Webcams under Linux typically show up as /dev/video0 so ffmpeg can read it 
# just like a regular movie. We then just grab one frame of the video stream 
# like a screenshot and save it as a picture.
ffmpeg -t 1 -i /dev/video0 -f mjpeg "$DIR/$FILE" 2>/dev/null

if [ $QUIET -eq 0 ]; then
    xdg-open "$DIR/$FILE"
fi
