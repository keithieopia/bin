#!/bin/bash

colorize () {
    SUCCESS="0;32"
    WARN="0;33"
    ERROR="0;31"
    ESC="\033["

    COLOR=\$${1:-NORMAL}

    echo -ne "${ESC}`eval echo ${COLOR}`m"
    cat
    echo -ne "${ESC}0m"
}

STATUS=$(ip route show match 0/0)

if [ ! -z "$STATUS" ]; then

    read GATEWAYIP IFACE LOCALIP <<< $(echo $STATUS | awk '{print $3" "$5" "$7}')
    GATEWAYMAC=$(ip neigh | grep $GATEWAYIP | awk '{print $5}')

    echo "INTERFACE:   $IFACE"
    echo "GATEWAY IP:  $GATEWAYIP"
    echo "GATEWAY MAC: $GATEWAYMAC"
    echo "LOCAL IP:    $LOCALIP"

    if [ -z $(curl -fsS http://google.com > /dev/null) ]; then
        PUBLICIP=$(dig +short myip.opendns.com @resolver1.opendns.com)

        echo "PUBLIC IP:   $PUBLICIP"

        echo "Online" | colorize SUCCESS
    else
        echo
        echo "Local Only" | colorize WARN
        exit 1
    fi
else
    echo "Interface Offline" | colorize ERROR
    exit 1
fi
