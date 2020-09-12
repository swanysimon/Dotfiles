#!/usr/bin/env sh

__prompt_command () {
    PREV_EXIT_CODE=$?
    history -a
    history -c
    history -r
    return $PREV_EXIT_CODE
}

PROMPT_DIRTRIM=3
PROMPT_COMMAND=__prompt_command

__reset_colors () {
    printf "\001%s\002" "$(tput sgr0)"
}

__set_color () {
    printf "\001%s\002" "$(tput setaf "$1")"
}

__git_prompt_string () (
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>/dev/null; then
        return 0
    fi

    printf " "

    if ! git rev-parse --verify HEAD >/dev/null 2>/dev/null; then
        printf "%s<initial git commit>" "$(tput bold)"
        return 0
    fi

    branch="$(git branch --show-current)"
    upstream="$(git rev-parse --abbrev-ref "@{upstream}" 2>/dev/null)"

    git update-index -q --really-refresh >/dev/null 2>/dev/null
    if git diff-index --quiet HEAD -- >/dev/null 2>/dev/null; then
        dirty_state=""
    else
        dirty_state="+"
    fi

    if [ "$upstream" = "@{upstream}" ]; then
        # upstream branch no longer exists is my best guess
        printf "%s%s|%s<unknown upstream>" "$dirty_state" "$branch" "$(tput bold)"
        return 0
    fi

    left_right="$(git rev-list --left-right --count "${branch}...${upstream}")"
    left_ahead="$(echo "$left_right" | cut -f 1)"
    right_ahead="$(echo "$left_right" | cut -f 2)"

    upward_arrow="\xe2\x86\x91"

    if [ "$left_ahead" -eq 0 ]; then
        branch_status=""
    else
        branch_status="${upward_arrow}${left_ahead}"
    fi

    if [ "$right_ahead" -eq 0 ]; then
        upstream_status=""
    else
        upstream_status="${upward_arrow}${right_ahead}"
    fi

    printf "%s%s%b|%s%b" "$dirty_state" "$branch" "$branch_status" "$upstream" "$upstream_status"
)

__status_prompt_string () {
    if [ "$PREV_EXIT_CODE" -eq 0 ]; then
        checkmark='\xe2\x9c\x93'
        printf "%s%b" "$(__set_color 2)" "$checkmark"
    else
        unicode_x='\xe2\x9c\x97'
        printf "(%s) %s%b" "$PREV_EXIT_CODE" "$(__set_color 1)" "$unicode_x"
    fi
}

PS1="$(__reset_colors)"
PS1="${PS1}$(__set_color 6)\h"
PS1="${PS1} $(__set_color 3)\w"
PS1="${PS1}$(__set_color 5)\$(__git_prompt_string)"
PS1="${PS1}$(__reset_colors)"
PS1="${PS1}\n"
PS1="${PS1}\$(__status_prompt_string)"
PS1="${PS1}$(__reset_colors) "
export PS1="$PS1"
