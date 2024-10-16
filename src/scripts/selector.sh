#!/bin/sh
# should allow selection of wifi, sound
#
font="firamono:size=13"
black="#000000"
white="#abb2bf"

function selector {
    options="browser\naudio\npower\ncancel"
    selection=$(echo -e $options | dmenu -fn $font -nb $black -nf $white -sb $white -sf $black)

    if [ "$selection" = "browser" ]; then 
        firefox
    elif [ "$selection" = "audio" ]; then 
        pavucontrol
    elif [ "$selection" = "power" ]; then 
        /home/jasshank/core/src/scripts/powermenu.sh 
    elif [ "$selection" = "cancel" ]; then 
        return
    fi
}

selector
