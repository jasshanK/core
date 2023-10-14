#!/bin/sh

interval=0

# colors 
black=#1e222a
green=#7eca9c
white=#abb2bf
grey=#282c34
blue=#7aa2f7
red=#d47d85
darkblue=#668ee3

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

	case $status in
		"Not charging") symbol="+";;
		"Charging") symbol="+";;
		Discharging) symbol="-";;
		Full) symbol="";;
	esac

	printf "^c$white^   ^d^ $capacity$symbol"
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
