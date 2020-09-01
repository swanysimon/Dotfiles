#!/usr/bin/env bash

__prompt_command () {
    PREV_EXIT_CODE=$?
    history -a
    history -c
    history -r
    return $PREV_EXIT_CODE
}

PROMPT_DIRTRIM=3
PROMPT_COMMAND=__prompt_command

__hostname_prompt_color () {
    declare -i COLOR_CODE
    if [ "$(uname)" == "Linux" ]; then
        COLOR_CODE=2
    elif [ "$(uname)" == "Darwin" ]; then
        COLOR_CODE=6
    else
        COLOR_CODE=1
    fi

    printf "\001%s\002" "$(tput setaf $COLOR_CODE)"
}

__working_directory_prompt_color () {
    printf "\001%s\002" "$(tput setaf 3)"
}

__git_prompt_string () {
    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        return 0
    fi

    declare LOCAL_BRANCH
    declare REMOTE_BRANCH
    declare LOCAL_REMOTE_DIFF
    declare UPWARD_ARROW
    declare -i LOCAL_AHEAD
    declare LOCAL_STATUS_STRING
    declare -i REMOTE_AHEAD
    declare REMOTE_STATUS_STRING

    LOCAL_BRANCH="$(git branch --show-current)"
    REMOTE_BRANCH="$(git rev-parse --symbolic-full-name --abbrev-ref "@{upstream}")"
    LOCAL_REMOTE_DIFF="$(git rev-list --left-right --count "${LOCAL_BRANCH}"..."${REMOTE_BRANCH}" 2>/dev/null)"

    # unicode upward arrow (u2191)
    UPWARD_ARROW="\xe2\x86\x91"

    LOCAL_AHEAD="$(cut -f 1 <<< "$LOCAL_REMOTE_DIFF")"
    if [ "$LOCAL_AHEAD" -ne 0 ]; then
        LOCAL_STATUS_STRING="${UPWARD_ARROW}${LOCAL_AHEAD}"
    fi

    REMOTE_AHEAD="$(cut -f 2 <<< "$LOCAL_REMOTE_DIFF")"
    if [ "$REMOTE_AHEAD" -ne 0 ]; then
        REMOTE_STATUS_STRING="${UPWARD_ARROW}${REMOTE_AHEAD}"
    fi

    printf " \001%s\002%s%b|%s%b" \
            "$(tput setaf 5)" \
            "$LOCAL_BRANCH" \
            "$LOCAL_STATUS_STRING" \
            "$REMOTE_BRANCH" \
            "$REMOTE_STATUS_STRING"
}

__status_prompt_string () {
    if [ $PREV_EXIT_CODE -eq 0 ]; then
        # print a green checkmark (u2713)
        printf "\001%s\002%b" "$(tput setaf 2)" "\xe2\x9c\x93"
    else
        # print a red x (u2717)
        printf "(${PREV_EXIT_CODE}) \001%s\002%b" "$(tput setaf 1)" "\xe2\x9c\x97"
    fi
}

PS1="\001$(tput sgr0)\002"
PS1="${PS1}\$(__hostname_prompt_color)\h"
PS1="${PS1} \$(__working_directory_prompt_color)\w"
PS1="${PS1}\$(__git_prompt_string)"
PS1="${PS1}\n\$(__status_prompt_string)"
PS1="${PS1}\001$(tput sgr0)\002 "

