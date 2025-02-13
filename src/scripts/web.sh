#!/bin/sh

font="firamono:size=13"
black="#000000"
white="#abb2bf"

function web {
    selection=$(dmenu -fn $font -nb $black -nf $white -sb $white -sf $black < /dev/null)

    # ${parameter/pattern/string}
    # parameter is the variable
    # if pattern begins with /, all matches of the pattern are replaced
    firefox "https://www.google.com/search?q="${selection// /+}
}

web
