#!/bin/bash
# tmux_split_pane.sh

splitPane () {
    case "$1" in 
        -h|--horizontal)
            shift 1
            splitBelow "$@" ;;
        -v|--vertical)
            shift 1
            splitRight "$@" ;;
        -s|--smart)
            shift 1
            smartSplit "$@" ;;
        *)
            echo "Unknown option '$1'" 1>&2
            return 2 ;;
    esac
}

splitBelow () {
    echo "Below" && return 0
    tmux split-window -t= -v -c '#{pane_current_path}' "$@"
}

splitRight () {
    echo "Right" && return 0
    tmux split-window -t= -h -c '#{pane_current_path}' "$@"
}

smartSplit () {
    # optimized for Menlo for Powerline font
    case "$(uname)" in
        Linux|Darwin)
            if [[ $((LINES*2)) -lt $COLUMNS ]]; then
                splitRight "$@"
            else
                splitBelow "$@"
            fi ;;
        *)
            echo "Unsupported system name '$(uname)'" 1>&2
            return 2 ;;
    esac
}

splitPane "$@"

