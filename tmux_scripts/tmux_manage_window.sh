#!/bin/bash
# tmux_manage_window.sh

manageWindow () {
    case "$1" in
        -n|--new)
            shift 1
            newWindow "$@" ;;
        -r|--rename)
            renameWindow ;;
        -s|--select)
            shift 1
            selectWindow "$@" ;;
        -w|--swap)
            shift 1
            swapWindow "$@" ;;
        *)
            echo "Unknown window management option '$1'" 1>&2
            return 2 ;;
    esac
}

newWindow () {
    tmux new-window -a "$@" && renameWindow
}

renameWindow () {
    local currentWindowName="$(displayMessage)"
    tmux command-prompt -p "Rename window '#W':" "rename-window '%1'"
    if [[ -z "$(displayMessage)" ]]; then
        tmux rename-window "$currentWindowName"
    fi
}

displayMessage () {
    tmux display-message -p '#{window_name}'
}

selectWindow () {
    case "$1" in
        -l|--last)
            tmux select-window -l ;;
        -n|--next)
            tmux select-window -n ;;
        -p|--previous)
            tmux select-window -p ;;
        ^[0-9]+$)
            tmux select-window -t $1 ;;
        *)
            echo "Unknown window selection option '$1'" 1>&2
            return 2 ;;
    esac
}

swapWindow () {
    case "$1" in
        -n|--next)
            tmux swap-window -t:+1 ;;
        -p|--previous)
            tmux swap-window -t:-1 ;;
        *)
            echo "Unknown window swapping option '$1'" 1>&2
            return 2 ;;
    esac
}

manageWindow "$@"

