#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    exit
else
    if [ -f $1 ] ; then
        case "${1,,}" in
            # unless you have an ancient version of tar, you do not need to 
            # specify the tarball's compression when extracting (-j,-z,-J flags)
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)           
                tar xvf "$1" ;;

            *.7z)        7z x "$1"       ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.exe)       cabextract "$1" ;;
            *.gz)        gunzip "$1"     ;;
            *.lzma)      unlzma "$1"     ;;
            *.rar)       unrar x "$1"    ;;
            *.xz)        unxz "$1"       ;;
            *.z)         uncompress "$1" ;;
            *.zip)       unzip "$1"      ;;
            
            *) 
                echo "extract: '$1' - unknown archive format" 
                exit 1
                ;;
        esac 
    else
        echo "extract: '$1' - not a file"
        exit 1
    fi
fi
