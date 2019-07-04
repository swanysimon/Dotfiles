#!/bin/sh

selectWorkspace () {
    local NEW_WORKSPACE_STRING="new workspace"
    if [ -z $@ ]; then
        i3-msg -t get_workspaces | jq -r 'sort_by(.focused == false, .name) | .[].name'
        echo $NEW_WORKSPACE_STRING
    else
        local SELECTED_WORKSPACE="$@"
        if [ "$NEW_WORKSPACE_STRING" = "$SELECTED_WORKSPACE" ]; then
            ~/.config/i3/create_new_i3_workspace.sh $NEW_WORKSPACE_STRING
        elif [ -n "$SELECTED_WORKSPACE" ]; then
            i3-msg workspace "$SELECTED_WORKSPACE" > /dev/null
        fi
    fi
}

selectWorkspace "$@"

