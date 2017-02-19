#!/bin/bash

sums() {
    echo "CRC: $(cksum $1 | awk '{print $1}')"
    echo "MD5: $(md5sum $1 | awk '{print $1}' | tr '[:lower:]' '[:upper:]')"
    echo "RIPEMD-160: $(openssl dgst -ripemd160 $1 | awk '{print $2}' | tr '[:lower:]' '[:upper:]')"
    echo "SHA-1: $(sha1sum $1 | awk '{print $1}' | tr '[:lower:]' '[:upper:]')"
    echo "SHA-256: $(sha256sum $1 | awk '{print $1}' | tr '[:lower:]' '[:upper:]')"

    SHA512="$(sha512sum $1 | awk '{print $1}' | tr '[:lower:]' '[:upper:]' | fold -w 64)"
    echo "SHA-512: $(head -1 <<< $SHA512)"
    echo ": $(tail -1 <<< $SHA512)" # leading colon is not a typo, it's used to make a blank column

    WHIRLPOOL="$(openssl dgst -whirlpool $1 | awk '{print $2}' | tr '[:lower:]' '[:upper:]' | fold -w 64)"
    echo "WHIRLPOOL: $(head -1 <<< $WHIRLPOOL)"
    echo ": $(tail -1 <<< $WHIRLPOOL)" # again, colon is not a typo
}


if [ -z ${1+x} ]; then
    echo "Usage: $(basename $0) [FILE] or [DIR]"
    exit 1
elif [ -f "$1" ]; then
    sums "$1" | column -t -s ':'
elif [ -d "$1" ]; then
#    FILES="$(find $@ -maxdepth 1 -type f -not -name 'SHA256SUMS' | sort)"

    if [ -f "SHA256SUMS" ]; then
        sha256sum -c <SHA256SUMS
    else
        echo "Generating SHA256SUMS..."

        find "$1" -maxdepth 1 -type f -not -name 'SHA256SUMS' | sort | \
        while read file; do
            sha256sum "$file"
        done > SHA256SUMS

        cat SHA256SUMS
    fi
fi