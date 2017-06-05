#!/bin/sh
# tmux_copy_paste.sh

copyPaste() {
    case "$1" in
        copy)
            shift 1
            copy "$@" ;;
        paste)
            shift 1
            paste "$@" ;;
        *)
            tmux display-message "$0: $1: unrecognized option" ;;
    esac
}

copy() {
    local COMMAND=getCopyCommand
    case "$1" in
        in-place)
            tmux send-keys -X copy-pipe 'xclip -in -selection clipboard' ;;
        exit)
            tmux send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard' ;;
        *)
            tmux display-message "$0: $1: unrecognized option" ;;
    esac
}

if [ -n $TMUX ]; then
    copyPaste "$@"
fi

