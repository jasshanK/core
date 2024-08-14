#!/bin/sh

interval=0
low_batt_value=20

# colors 
white=#abb2bf
red=#d47d85

sound() {
    mute="$(amixer get Master | tail -2 | grep -c "\[on\]" || "2")"

    case $mute in 
        "0") printf "^c$white^ 󰖁 ^d^" ;;
        "2") printf "^c$white^ 󰕾 ^d^" ;;
    esac
}

battery() {
	capacity="$(cat /sys/class/power_supply/BAT1/capacity)"
	status="$(cat /sys/class/power_supply/BAT1/status)"
	symbol=""
    batt_colour=$white
    icon=

    if [ $((capacity)) == " " ]; then
        icon=" "
        capacity=" "
        symbol=" "
    else
        case $status in
            "Not charging") symbol="-";;
            "Charging") symbol="+";;
            Discharging) symbol="-";;
            Full) symbol="";;
        esac

        if [ $((capacity)) -lt $low_batt_value ]; then 
            batt_colour=$red
            if [ $((interval % 2)) -eq 0 ]; then
                icon=" "
            fi
        fi
    fi

	printf "^c$batt_colour^ $icon ^d^ $capacity$symbol"
}

wlan() {
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) printf "^c$white^ 󰤨  ^d^%s" " ^c$white^Connected" ;;
	down) printf "^c$white^ 󰤭  ^d^%s" " ^c$white^Disconnected" ;;
	esac
} 

clock() {
	printf "^c$white^ 󱑆 ^d^"
	printf "^c$white^ $(date '+%H:%M')  "
}

delimiter() {
    printf "^c$white^ | ^d^"
}

while true; do

	[ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] 
	interval=$((interval + 1))

    sleep 1 && xsetroot -name "$(battery) $(delimiter) $(sound) $(delimiter) $(wlan) $(delimiter) $(clock)"


done
