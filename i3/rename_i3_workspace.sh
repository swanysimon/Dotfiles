#!/bin/sh

renameCurrentWorkspace () {
    local CURRENT_WORKSPACE="$(i3-msg -t get_workspaces | jq 'map(select(.focused))[0]')"
    local CURRENT_WORKSPACE_NAME="$(echo $CURRENT_WORKSPACE | jq '.name')"
    local CURRENT_WORKSPACE_NUMBER="$(echo $CURRENT_WORKSPACE | jq -r '.num')"

    i3-input \
        -F "rename workspace to ${CURRENT_WORKSPACE_NUMBER}:%s" \
        -P "Rename workspace ${CURRENT_WORKSPACE_NAME} to: "
}

renameCurrentWorkspace

