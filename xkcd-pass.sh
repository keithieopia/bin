#!/bin/bash

# "correct horse battery staple" password scheme generator
# See: https://xkcd.com/936/
#
# Yes, there are over 9000 implementations of xkcd's password scheme, but for 
# some reason most of the authors of these don't bother to actually pick the words 
# securely using a CSPRNG
#
# Enter the power of:
#    shuf --random-source=/dev/urandom

# default number of words is 4 if not specified (per the comic, I suggest more)
NUM_WORDS="${1:-4}"

# find a pre-installed dictionary of words
files=("/usr/dict/words" "/usr/share/dict/words" "/usr/share/dict/cracklib-small")
for file in "${files[@]}"; do
    if [ -f $file ]; then
        DICT="$file"
        break
    fi
done

if [ -z $DICT ]; then
    echo -e "\e[0;31mNo dictionary file found!\033[0m"
    exit 1
fi

# remove "words" starting with non-sense
DICT=$(grep -E '^[a-zA-Z]{3,6}$' "$DICT")

WORDS=$(shuf -n $NUM_WORDS --random-source=/dev/urandom <<< "$DICT" | paste -s -d ' ')

echo "${WORDS// /} ($WORDS)"
