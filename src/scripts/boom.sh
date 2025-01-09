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
    "-n" )
        cd $selected_dir ;;
    * )
        if [ "$TMUX" == "" ]; then
            tmux new-session -c $selected_dir
        else 
            echo "boom: In TMux session, use -n flag"
        fi
esac
