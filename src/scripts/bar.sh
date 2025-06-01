#!/bin/sh

interval=0
low_batt_value=20

# colors 
white=#abb2bf
red=#d47d85

delimiter() {
    printf "^c$white^ | ^d^"
}

sound() {
    mute="$(amixer get Master | tail -2 | grep -c "\[on\]" || "2")"

    case $mute in 
        "0") printf "^c$white^ 󰖁 ^d^" ;;
        "2") printf "^c$white^ 󰕾 ^d^" ;;
    esac
}

battery() {
    capacity=""
    status=""
	symbol=""
    batt_colour=$white
    icon=

    if [ -z $(ls -A /sys/class/power_supply/) ]; then
        icon=" "
        capacity=" "
        symbol=" "
    else
        capacity="$(cat /sys/class/power_supply/BAT1/capacity)"
        status="$(cat /sys/class/power_supply/BAT1/status)"

        case $status in
            "Not charging") symbol="-";;
            "Charging") symbol="+";;
            "Discharging") symbol="-";;
            "Full") symbol="";;
        esac

        if [ $((capacity)) -lt $low_batt_value ]; then 
            batt_colour=$red
            if [ $((interval % 2)) -eq 0 ]; then
                icon=" "
            fi
        fi
    fi

    printf "^c$batt_colour^ $icon ^d^ $capacity$symbol $(delimiter)"
}

network() {
    is_connected=0

    case "$(cat /sys/class/net/en*/operstate 2>/dev/null)" in
	    up) 
            is_connected=1

            printf "^c$white^ 󰤨  ^d^%s" " ^c$white^Ethernet "
            ;;
    esac


    case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
        up) 
            is_connected=1

            ssid="$(nmcli -t -f name,device connection show --active | grep -v -e lo -e Wired | cut -d\: -f 1 | cut -d' ' -f 1)"

            printf "^c$white^ 󰤨  ^d^%s" " ^c$white^$ssid" 
            ;;
    esac

    if [ $is_connected == 0 ]; then 
        printf "^c$white^ 󰤭  ^d^%s" 
    fi
} 

clock() {
	printf "^c$white^ $(date '+%d/%m')  "
	printf "^c$white^ $(date '+%H:%M')  "
}

while true; do
	interval=$((interval + 1))

    sleep 1 && xsetroot -name "$(battery) $(sound) $(delimiter) $(network) $(delimiter) $(clock)"
done
