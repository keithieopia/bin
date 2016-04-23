##
## Archiving
##

mktar () { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz () { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz () { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

extract () {
    if [ -f $1 ] ; then
        case "${1,,}" in
            *.7z)                    7z x "$1"       ;;
            *.bz2)                   bunzip2 "$1"    ;;
            *.gz)                    gunzip "$1"     ;;
            *.rar)                   rar x "$1"      ;;
            *.tar)                   tar xvf "$1"    ;;
            *.tar.bz2|*.tbz2|*.tbz)  tar xvjf "$1"   ;;
            *.tar.gz|*.tgz)          tar xvzf "$1"   ;;
            *.xz)                    tar xJf "$1"    ;;
            *.zip)                   unzip "$1"      ;;
            *.z)                     uncompress "$1" ;;
            *)                       echo "don't know how to extract '$1'..." ;;
        esac 
    else
        echo "'$1' is not a valid file!"
    fi
}
