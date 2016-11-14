##
## Directory Functions
##

alias copy='rsync -ah --progress'

# list only dirs
alias lsd='ls -l | grep "^d"'   #list only directories


# Makes dir then cd into it
mkcdr () {
    mkdir -p -v $1
    cd $1
}

# Calculate size of directories
ds () {
    echo "size of directories in MB"
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
        echo "you did not specify a directy, using pwd"
        DIR=$(pwd)
        find $DIR -maxdepth 1 -type d -exec du -sh \{\} \; | sort -nr
    else
        find $1 -maxdepth 1 -type d -exec du -sh \{\} \; | sort -nr
    fi
}
