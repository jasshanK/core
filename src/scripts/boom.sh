#!/bin/sh

find_dir() {
    local dir
    dir=$(find $HOME -maxdepth 3 -type d  | fzf +m)

    echo $dir
}

selected_dir=$(find_dir)

if [ "$selected_dir" == "" ]; then
    echo "Exiting..."
    return
fi

case $1 in
    "t" )
        tmux new-session -c $selected_dir ;; 
    * )
        cd $selected_dir ;;
esac
