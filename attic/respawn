#!/bin/bash

usage () {
cat <<HELP 
Indefinitely restart a program after it exits

Usage: $(basename "$0") [APP]

To Kill:
   Run '/tmp/respawn/respawnkill' or send a SIGUSR1 to kill this 
   daemon once started.

Logging:
   All output from the given program will be captured in /tmp/respawn/*.log
   Each time the program restarts, a new dated log file is created


https://github.com/keithieopia/bin/
    
Copyright (c) 2016 Timothy Keith
Licensed under the MIT license.
HELP
}

if [ -z "$1" ]; then 
    usage
    exit 1
elif [ "$1" == "-h" ]; then
    usage
    exit
fi


cleanup() {
    TIMESTAMP=`date "+%Y-%m-%d-%H:%M:%S"`
    echo -e "\e[34m[$TIMESTAMP] \e[33mProgram has exited, but SIGUSR1 received so not restarting...\e[39m"

    echo -e "\e[34mRemoving kill script...\e[39m"
    rm /tmp/respawn/respawnkill
    exit 0
}

if [ ! -d "/tmp/respawn" ]; then
    mkdir /tmp/respawn
fi

echo -e "\e[34mCreating kill script...\e[39m"
echo "#!/bin/bash" >> /tmp/respawn/respawnkill
echo "kill -SIGUSR1 ${$}" >> /tmp/respawn/respawnkill
chmod +x /tmp/respawn/respawnkill

TIMESTAMP=`date "+%Y-%m-%d-%H:%M:%S"`
echo -e "\e[34m[$TIMESTAMP] \e[32mStarting $1...\e[39m"
$1 > /tmp/respawn/$1-$TIMESTAMP.log 2>&1

trap cleanup SIGUSR1
while : ; do
    TIMESTAMP=`date "+%Y-%m-%d-%H:%M:%S"`
    echo -e "\e[34m[$TIMESTAMP] \e[33mProgram exited, restarting...\e[39m"
    $1 > /tmp/respawn/$1-$TIMESTAMP.log 2>&1
done
