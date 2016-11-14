#!/bin/bash

# read feh's current background file
BG="$(tail -n 1 ~/.fehbg | awk '{print $NF}' | tr -d \')"

# get the params used on the background file "ex: feh --bg-scale"
FEH="$(tail -n 1 ~/.fehbg | sed -r 's/\S+//3')"

# generate the quote, fortune sometimes has tabs which imagemagick can't handle
QUOTE="$(fortune -s | sed -e 's/[ \t]*//')"

# put it on the background
montage -background none -fill 'rgba(255,255,255,0.5)' \
        -font Dejavu-Sans -pointsize 48 \
        label:"$QUOTE" +set label \
        -shadow -geometry +5+5 \
        -gravity center \
        /tmp/quote.png

composite -gravity center -gravity center /tmp/quote.png $BG /tmp/screen.png

# set the BG to the new image with the quote, but backup the original config 
# so it can be used again
cp ~/.fehbg ~/.fehbg_orig
eval $FEH /tmp/screen.png
mv ~/.fehbg_orig ~/.fehbg
