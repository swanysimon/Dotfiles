#!/usr/bin/env bash


__source_matching_in_dir () {
    if [ -d "$1" ]; then
	while read -r file; do
	    # shellcheck disable=SC1090
	    . "$file"
	done < <(find -L "$1" -type f -name "$2")
    fi
}


shopt -s checkwinsize
shopt -s cmdhist
shopt -s histappend


# shellcheck source=./shell/prompt.sh
__source_if_file_exists "${DOTFILES_DIR}/shell/prompt.sh"
# shellcheck source=./shell/bash_functions.sh
__source_if_file_exists "${DOTFILES_DIR}/shell/bash_functions.sh"
# load all "plugins"
__source_matching_in_dir "${DOTFILES_DIR}/shell/hidden" '*\.sh'


if command -v __git_complete >/dev/null && command -v __git_main >/dev/null; then
    __git_complete g __git_main
fi


if command -v brew >/dev/null; then
    if [ -d "$(brew --prefix)/etc/bash_completion.d" ]; then
        BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
        export BASH_COMPLETION_COMPAT_DIR="$BASH_COMPLETION_COMPAT_DIR"
        __source_if_file_exists "$(brew --prefix)/share/bash-completion/bash_completion"
    fi

    __source_if_file_exists "$(brew --prefix)/etc/profile.d/bash_completion.sh"
else
    __source_if_file_exists /etc/bash_completion
fi


if command -v thefuck >/dev/null; then
    eval "$(thefuck --alias)"
fi


if command -v pyenv >/dev/null; then
    eval "$(pyenv init -)"
    export PATH="$PATH"
fi


if command -v plz >/dev/null; then
    # shellcheck disable=SC1090
    source <(plz --completion_script)
fi
