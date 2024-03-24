#!/bin/sh

function powermenu {
    options="cancel\nshutdown\nreboot\nsuspend\nlock"
    selection=$(echo -e $options | dmenu -fn "firamono:size=13")

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

