#!/bin/sh

note_store="/home/jasshank/notes/noter/"

entry_mode() {
    printf "note name: "
    read name
    
    path="$note_store$name"".md"
    $EDITOR "$path"
    
    cat "$path"
}

view_mode() {
    selected_file=$(find $note_store -type f| fzf +m)

    cat "$selected_file"
}

edit_mode() {
    selected_file=$(find $note_store -type f| fzf +m)

    $EDITOR "$selected_file"

    cat "$selected_file"
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
