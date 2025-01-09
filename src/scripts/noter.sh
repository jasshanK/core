#!/bin/sh

note_store="/home/jasshank/notes/noter/"

display() {
    filename=$(basename -- "$1")
    echo -e "\x1b[43m\x1b[30m$filename\x1b[0m"
    echo

    sed -e 's|^# \(.*\)|\x1b[31m[\1]\x1b[0m|' \
        -e 's|^## \(.*\)|\x1b[32m[\1]\x1b[0m|' \
        -e 's|^### \(.*\)|\x1b[33m[\1]\x1b[0m|' \
        -e 's|^#### \(.*\)|\x1b[34m[\1]\x1b[0m|' \
        -e 's|^- \(.*\)|* \1|' \
        -e 's|^\( *\)- \(.*\)|\1. \2|' \
        -e 's|\*\*\([^\*\*]*\)\*\*|\x1b[1m\1\x1b[0m|g' \
        -e 's|\*\([^\*]*\)\*|\x1b[3m\1\x1b[0m|g' \
        -e 's|`\([^`]*\)`|[\1]|g' \
        $1
}

entry_mode() {
    printf "note name: "
    read name
    
    path="$note_store$name"".md"
    $EDITOR "$path"
    
    display "$path"
}

view_mode() {
    selected_file=$(find $note_store -type f| fzf +m)

    display "$selected_file"
}

edit_mode() {
    selected_file=$(find $note_store -type f| fzf +m)

    $EDITOR "$selected_file"

    display "$selected_file"
}

del_mode() {
    selected_file=$(find $note_store -type f| fzf +m)

    printf "Delete $selected_file?[y/n] "
    read input

    case $input in
        "y")
            rm "$selected_file" ;;
        "Y")
            rm "$selected_file" ;;
        "n")
            echo "Cancelled..." ;;
        "N")
            echo "Cancelled..." ;;
    esac
}

modes="new\nview\nedit\ndelete"
selected_mode=$(printf "$modes" | fzf +m)

case $selected_mode in
    "new")
        entry_mode ;;
    "view")
        view_mode ;;
    "edit")
        edit_mode ;;
    "delete")
        del_mode ;;
esac
