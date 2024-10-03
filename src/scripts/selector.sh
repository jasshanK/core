#!/bin/sh
# should allow selection of wifi, sound
function selector {
    options="power\ncancel"
    selection=$(echo -e $options | dmenu -fn "firamono:size=13")

    if [ "$selection" = "power" ]; then 
        ./powermenu.sh 
    elif [ "$selection" = "cancel" ]; then 
        return
    fi
}

selector
