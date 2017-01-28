#!/bin/bash

# Other Examples:
#   GOOD - https://gist.github.com/jinyeow/dd51376dfff1b8947c2f
#   https://github.com/muse/Captain/blob/master/captain
#   https://gist.github.com/vixus0/4141617
#   IDEAS - https://github.com/jaagr/polybar

while getopts d option; do
    case "$option" in
        d) DEBUG=1 ;;
    esac
done

# Colors
WHITE="#FCFDFA"
GREEN="#27AE60"
ORANGE="#F29B12"
YELLOW="#F0C30F"
RED="#C0392B"
BLUE="#2A80B8"
TEAL="#15A88B"
PURPLE="#8E44AD"
BLACK="#252525"
BG_COLOR="$(bspc config normal_border_color)"

# Dimensions
HEIGHT="40"
WIDTH=$(xdpyinfo | awk -F'[ x]+' '/dimensions:/{print $3}')

# Fonts
FONT="DroidSansMono:size=10"
FONTAWESOME="FontAwesome:size=10"

# Other
NET_IFACE="wlp1s0"
PKG_UPDATE_INTERVAL="86400"
LOGITECH_DEV="2" # Logitech mouse device number, run 'solaar show'

##
## Internal Vars
##
PROCESS_NAME=$(basename $0)
LEMONBAR_ARGS="-n 'lemonpanel' -g $HEIGHTx$WIDTH+0+0 -b -d -f $FONT -f $FONTAWESOME -F $WHITE -B $BLACK -p"
PANEL_FIFO=/tmp/statusbar.fifo
DESKTOPS=$(bspc query -T -m | jshon -e desktops -a -e name -u)

##
## Sub-process Management
################################################################################

if [ $(pgrep -cx $PROCESS_NAME) -gt 1 ]; then
    echo "$PROCESS_NAME already running."
    exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"


##
## Helper Functions
################################################################################

human_bytes () {
    if [[ $1 =~ ^-?[0-9]+$ ]]; then
        bytes=$1
        kilobytes=$((bytes >> 10))
        megabytes=$((bytes >> 20))
        gigabytes=$((bytes >> 30))

        if [ $gigabytes -gt 1 ]; then
            echo "$gigabytes" "GB"
        elif [ $megabytes -gt 1 ]; then
            echo "$megabytes" "MB"
        elif [ $kilobytes -gt 1 ]; then
            echo "$kilobytes" "KB"
        else
            echo "$bytes" "B"
        fi
    else
        # not an integer, just return what was given
        echo $1
    fi
}

icon () {
    case $1 in
        "batt-0")   echo -ne "\uf244" ;;
        "batt-25")  echo -ne "\uf243" ;;
        "batt-50")  echo -ne "\uf242" ;;
        "batt-75")  echo -ne "\uf241" ;;
        "batt-100") echo -ne "\uf240" ;;
        "box")      echo -ne "\uf187" ;;
        "chip")     echo -ne "\uf2db" ;;
        "calendar") echo -ne "\uf073" ;;
        "clock")    echo -ne "\uf017" ;;
        "download") echo -ne "\uf019" ;;
        "drive")    echo -ne "\uf0a0" ;;
        "gears")    echo -ne "\uf085" ;;
        "home")     echo -ne "\uf015" ;;
        "mouse")    echo -ne "\uf245" ;;
        "plug")     echo -ne "\uf1e6" ;;
        "upload")   echo -ne "\uf093" ;;
        "vol-off")  echo -ne "\uf026" ;;
        "vol-on")   echo -ne "\uf028" ;;
    esac
}

format () {
    echo -n "%{B$2}"
    echo -n " $(icon $1) "

    # remove leading spaces and pad
    echo -n "$3" | sed -e 's/^[[:space:]]*//' | sed -e :a -e 's/^.\{1,5\}$/& /;ta'

    echo -n " %{B$BG_COLOR}"
}

subprocess() {
    while true; do
        local OUTPUT="$($1)"

        if [[ "$OUTPUT" != "$LAST_OUTPUT" ]]; then
            local LAST_OUTPUT="$OUTPUT"
            echo "$OUTPUT"
        fi

        sleep $2
    done > "$PANEL_FIFO" &
}

##
## Data Collection
################################################################################

cpu() {
    local MPSTAT=$(mpstat | tail -1)
    local CPU=$(echo "100 - $(awk '{print $13}' <<< $MPSTAT)" | bc -l)

    echo "CPU $CPU%"
}

drives() {
    echo "ROOT $(/bin/df | grep 'storage-root' | head -1 | awk '{print $5}')"
    echo "HOME $(/bin/df | grep 'storage-home' | head -1 | awk '{print $5}')"
}

ram() {
    local FREE=$(free -m | sed -n '2p' | awk '{print $7}')
    local TOTAL=$(free -m | sed -n '2p' | awk '{print $2}')
    local USED=$(echo "100 - (($FREE / $TOTAL) * 100)" | bc -l)

    echo "RAM $(awk '{printf("%.2f", $1)}' <<< "$USED")%"
}

desktop() {
    echo "DESKTOP $(bspc query -T -d | jshon -e name -u)"
}

net() {
    local CACHE_FILE="/tmp/net_$NET_IFACE"

    if [[ $(< /sys/class/net/$NET_IFACE/operstate) == "up" ]]; then
        local TIME=$(date +%s)
        local TX_TOTAL=$(< /sys/class/net/$NET_IFACE/statistics/tx_bytes)
        local RX_TOTAL=$(< /sys/class/net/$NET_IFACE/statistics/rx_bytes)

        if [ -f "$CACHE_FILE" ]; then
            local TIME_CACHE=$(stat -c %Y $CACHE_FILE)
            local ELAPSED_TIME=$(bc <<< "$TIME - $TIME_CACHE")

            local TX_TOTAL_CACHE=$(awk '{print $1}' < "$CACHE_FILE")
            local RX_TOTAL_CACHE=$(awk '{print $2}' < "$CACHE_FILE")

            if [[ "$ELAPSED_TIME" != 0 ]]; then
                local TX=$(bc <<< "($TX_TOTAL - $TX_TOTAL_CACHE) / $ELAPSED_TIME")
                local RX=$(bc <<< "($RX_TOTAL - $RX_TOTAL_CACHE) / $ELAPSED_TIME")

                echo "NET_UP $(human_bytes $TX)"
                echo "NET_DOWN $(human_bytes $RX)"
            else
                echo "NET_UP 0"
                echo "NET_DOWN 0"
            fi
        else
            echo "NET_UP ???"
            echo "NET_DOWN ???"
        fi

        # Write the cache file
        echo "$TX_TOTAL $RX_TOTAL" > "$CACHE_FILE"
    else
        echo "NET_UP ---"
        echo "NET_DOWN ---"
    fi
}

updates() {
    # update the pacman db if it's older than $UPDATE_AFTER seconds
    local LAST_UPDATE=$(grep 'synchronizing package lists' /var/log/pacman.log | \
                        tail -1 | awk '{print $1" "$2}' | tr -d \[\])
    local LAST_TIME=$(date -d "$LAST_UPDATE" +%s)
    local TIME=$(date +%s)

    if ((TIME-LAST_TIME > PKG_UPDATE_INTERVAL)); then
        # update the db or die if it fails
        # you'll want to setup a NOPASSWD sudo entry
        if ! sudo pacman -Sy &> /dev/null; then
            local FAILED=1
        else
            local FAILED=0
        fi
    fi

    if [ "$FAILED" != "1" ]; then
        # list the number of updates available
        local NUM_UPDATES=$(pacman -Qu | wc -l)

        if ((NUM_UPDATES > 0)); then
            echo "UPDATES $NUM_UPDATES pkgs"
        else
            echo "UPDATES up-to-date"
        fi
    else
        echo "UPDATES db outdated!"
    fi
}

battery () {
    if [ "$(< /sys/class/power_supply/BAT1/status)" == "Discharging" ]; then
        echo "AC 0"
    else
        echo "AC 1"
    fi

    echo "BATTERY $(< /sys/class/power_supply/BAT1/capacity)"
}

mouse () {
    # Sanity check first
    if lsusb | grep -q 'Logitech, Inc. Unifying Receiver'; then
        # Solaar takes a while to run, so first output something so we
        # know this widget is in fact running
        SOLAAR=$(solaar show $LOGITECH_DEV | grep 'Battery: ' | awk '{print $2}' | tr -d %,)

        if [[ "$SOLAAR" =~ '^[0-9]+$' ]]; then
            # not a number, something bad happened
            echo "MOUSE ???"
        else
            echo "MOUSE $SOLAAR%"
        fi
    else
        echo "MOUSE ---"
    fi
}

volume () {
    local VOLUME="$(amixer -D pulse get Master | tail -1)"

    if grep -q 'off' <<< "$VOLUME"; then
        echo "MUTED 1"
    else
        echo "MUTED 0"
    fi

    echo "VOLUME $(awk '{print $5}' <<< $VOLUME | tr -d \[\])"
}

datetime () {
    echo "DATE $(date +"%a, %b") $(date +"%e" | tr -d ' ')"
    echo "TIME $(date +"%l:%M %P")"
}


##
## Timers
################################################################################

subprocess cpu 2
subprocess ram 2
subprocess desktop 2
subprocess net 5
subprocess volume 5
subprocess datetime 5
subprocess battery 10
subprocess drives 300
subprocess updates 21600
subprocess mouse 21600


##
## Main lemonbar loop
################################################################################

while read -r line; do
    if [[ "$DEBUG" == "1" ]]; then
        (>&2 echo "$line")
    fi


    #
    # Formatting
    #
    SECTION=$(cut -d' ' -f1 <<< "$line")
    OUTPUT=$(cut -d' ' -f2- <<< "$line")

    case $SECTION in
        AC)
            # Used in BATTERY case
            AC="$OUTPUT"
            ;;

        BATTERY)
            if [[ "$AC" == 1 ]]; then
                BATT_ICON="plug"
            else
                if [[ "$OUTPUT" > 80 ]]; then
                    BATT_ICON="batt-100"
                elif [[ "$OUTPUT" > 60 ]]; then
                    BATT_ICON="batt-75"
                elif [[ "$OUTPUT" > 40 ]]; then
                    BATT_ICON="batt-50"
                elif [[ "$OUTPUT" > 20 ]]; then
                    BATT_ICON="batt-25"
                else
                    BATT_ICON="batt-0"
                fi
            fi
            BATTERY=$(format "$BATT_ICON" "$RED" "$OUTPUT%")
            ;;

        CPU)
            CPU=$(format "gears" "$ORANGE" "$OUTPUT")
            ;;

        DATE)
            DATE=$(format "calendar" "$GREEN" "$OUTPUT")
            ;;

        DESKTOP)
            # Handled below...
            DESKTOP="$OUTPUT"
            ;;

        HOME)
            HOME=$(format "home" "$TEAL" "$OUTPUT")
            ;;

        IO)
            IO=$(format "drive" "$ORANGE" "$OUTPUT%")
            ;;

        MOUSE)
            MOUSE=$(format "mouse" "$RED" "$OUTPUT")
            ;;

        MUTED)
            # Handled in VOLUME case
            MUTED="$OUTPUT"
            ;;

        NET_DOWN)
            NET_DOWN=$(format "download" "$PURPLE" "$OUTPUT")
            ;;

        NET_UP)
            NET_UP=$(format "upload" "$PURPLE" "$OUTPUT")
            ;;

        RAM)
            RAM=$(format "chip" "$ORANGE" "$OUTPUT")
            ;;

        ROOT)
            ROOT=$(format "drive" "$TEAL" "$OUTPUT")
            ;;

        TIME)
            TIME=$(format "clock" "$GREEN" "$OUTPUT")
            ;;

        UPDATES)
            UPDATES=$(format "box" "$YELLOW" "$OUTPUT")
            ;;

        VOLUME)
            # Volume
            if [[ "$MUTED" == 1 ]]; then
                VOL_ICON="vol-off"
            else
                VOL_ICON="vol-on"
            fi
            VOLUME=$(format "$VOL_ICON" "$BLUE" "$OUTPUT")
            ;;
    esac

    #
    # Output to lemonbar
    #

    echo -n " " # spacing

    # Left Side: Desktops
    while read -r desk; do
        if [[ "$desk" == "$DESKTOP" ]]; then
            echo -n "%{F$TEAL}$desk%{F-} "
        else
            echo -n "%{A:bspc desktop -f $desk:}"
            echo -n "%{F$BLACK}$desk%{F-}"
            echo -n "%{A} "
        fi
    done <<< "$DESKTOPS"

    # Right Side: Status
    echo -n "%{r}"
    echo -n "${CPU}${RAM}"
    echo -n "${ROOT}${HOME}"
    echo -n "${NET_DOWN}${NET_UP}"
    echo -n "${UPDATES}"
    echo -n "${VOLUME}"
    echo -n "${MOUSE}${BATTERY}"
    echo -n "${DATE}${TIME}"
    echo "" # newline

done < "$PANEL_FIFO" | lemonbar $LEMONBAR_ARGS | bash
