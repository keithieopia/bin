#!/bin/bash

LEN=10
CASE="alpha"

function alpha() {
    echo $(</dev/urandom tr -cd "[:$CASE:]" | head -c ${1:-$LEN})
}

function word() {
    words=$(aspell dump master | grep -o -w '\w\{4,8\}')
    shuf -n 1 --random-source=/dev/urandom <<< "$words"
}

function cia() {
    LEN=2
    digraph=$(alpha)

    tr '[:lower:]' '[:upper:]' <<< "$digraph$(word)"
}

function mac_address() {

    # Second char of a MAC address is reserved for multicast if it's odd.
    # Rather than writing this specific use case, it's often quicker just to
    # generate addresses until the second char is even

    while : ; do
        mac="$(hexdump -vn 6 -e ' /1 "%02x"' /dev/urandom)"
        [[ "13579bdf" =~ ${mac:1:1} ]] || break
    done

    # add colons every two chars to make the hex string into a MAC address
    echo $mac | fold -w2 - | paste -sd ':' -
}

function num() {
    echo $(</dev/urandom tr -cd '[:digit:]' | head -c ${1:-$LEN})
}

function pass() {
    echo $(</dev/urandom tr -cd '[:graph:]' | head -c ${1:-$LEN})
}

function port() {
    RANGE="$(awk '{print $2}' </proc/sys/net/ipv4/ip_local_port_range)"

    shuf -n 1 -i 1024-$RANGE --random-source=/dev/urandom
}

function usage() {
cat <<HELP
Create random passwords, MAC addresses, letters, or numbers using /dev/urandom

Usage: $(basename "$0") [OPTION...] FORMAT

  alpha         uppercase and lowercase letters
  cia           CIA cryptonym; a digraph combinded with a word
  digit         digits
  lower         lowercase letters
  mac           MAC address
  passwd        password (letters, numbers, symbols)
  port          random port (1024 - ip_local_port_range)
  upper         uppercase letters
  word          dictionary word

  -l [NUM]      number of chars to generate (default: 10)
  -h            display this help


https://github.com/keithieopia/bin/

Copyright (c) 2016 - 2017 Timothy Keith
Licensed under the MIT license.
HELP
}


while getopts l:c:h option; do
    case $1 in
        -l) LEN=${OPTARG}  ;;
        -h) usage && exit  ;;
    esac
done

shift $((OPTIND-1))


case $1 in
    alpha)  alpha
            exit
            ;;
    cia)    cia
            exit
            ;;
    digit)  num
            exit
            ;;
    lower)  CASE="lower"
            alpha
            exit
            ;;
    mac)    mac_address
            exit
            ;;
    pass)   pass
            exit
            ;;
    port)   port
            exit
            ;;
    upper)  CASE="upper"
            alpha
            exit
            ;;
    word)   word
            exit
            ;;
    * )     usage
            exit 1
esac
