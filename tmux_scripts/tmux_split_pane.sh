#!/bin/bash
# tmux_split_pane.sh

splitPane () {
    case "$1" in
        -h|--horizontal)
            shift 1
            splitBelow $@ ;;
        -v|--vertical)
            shift 1
            splitRight $@ ;;
        -s|--smart)
            shift 1
            smartSplit $@ ;;
        *)
            echo "Unknown option '$1'" 1>&2
            return 2 ;;
    esac
}

splitBelow () {
    tmux split-window -v -c '#{pane_current_path}' $@
}

splitRight () {
    tmux split-window -h -c '#{pane_current_path}' $@
}

smartSplit () {
    # Menlo and Menlo for Powerline appear to have a 4:9 width:height ratio
    # adjust the coefficients to suite your font
    if [[ $((LINES*4)) -lt $((COLUMNS*9)) ]]; then
        splitRight $@
    else
        splitBelow $@
    fi
}

[[ -n $TMUX ]] && splitPane "$@"

