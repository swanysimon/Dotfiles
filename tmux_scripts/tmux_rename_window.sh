#!/bin/bash
# tmux_rename_window.sh

renameWindow () {
    case "$1" in
        "")
            tmux display-message "Window cannot be named the empty string" ;;
        default)
            tmux rename-window "#{command}" ;;
        *)
            tmux rename-window "$1 #{command}" ;;
    esac
}

[[ -n $TMUX ]] && renameWindow "$@"

