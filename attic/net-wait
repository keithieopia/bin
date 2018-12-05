#!/bin/bash

TRIES=6
WAIT=10

# Wait a maximum of one minute for network connectivity
# then die if we don't get it
ROUTE=$(ip route show match 0/0)

n=0
while [ -z "$ROUTE" ]; do
    if [ "$n" -eq 0 ]; then
        echo "No network connectivity, trying again in $WAIT secs..."
    fi

    n=$[$n+1]

    if [ $n -ge "$TRIES" ]; then
        echo "No network connectivity after $TRIES tries!"
        exit 1
    else
        sleep "${WAIT}s"
        ROUTE=$(ip route show match 0/0)
    fi
done

exec $@
