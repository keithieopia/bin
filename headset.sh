#!/bin/bash

if ! systemctl is-active bluetooth > /dev/null; then
    sudo systemctl start bluetooth
fi

if bluetoothctl <<< "info $HEADSET_MAC" | grep -q "Connected: no"; then

    bluetoothctl <<< "power on" > /dev/null
    
    for i in {1..5}; do
    
        bluetoothctl <<< "connect $HEADSET_MAC" > /dev/null
        
        if bluetoothctl <<< "info $HEADSET_MAC" | grep -q "Connected: yes"; then
            echo "connected!"
            exit
        else
            sleep 3
        fi
    done
    
    echo "failed to connect"
    exit 1
else
    bluetoothctl <<< "disconnect $HEADSET_MAC" > /dev/null
    echo "disconnected!"
fi
