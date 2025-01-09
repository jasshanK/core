#!/bin/sh

font="firamono:size=13"
black="#000000"
white="#abb2bf"

function powermenu {
    options="cancel\nshutdown\nreboot\nsuspend\nlock"
    selection=$(echo -e $options | dmenu -fn $font -nb $black -nf $white -sb $white -sf $black)

    if [ "$selection" = "shutdown" ]; then 
        poweroff
    elif [ "$selection" = "reboot" ]; then 
        reboot
    elif [ "$selection" = "suspend" ]; then 
        systemctl suspend
    elif [ "$selection" = "lock" ]; then 
        xflock4
    elif [ "$selection" = "cancel" ]; then 
        return
    fi
}

powermenu

