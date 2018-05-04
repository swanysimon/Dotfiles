#!/bin/sh

getNewWorkspaceNumber() {
    i3-msg -t get_workspaces \
        | jq -r 'sort_by(.num) | .[].num' \
        | awk '{ a[$1] } END { for (i = 1; i in a; ++i) {}; print i }'
}

i3-msg workspace "$(getNewWorkspaceNumber):$@" > /dev/null

