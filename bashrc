#!/usr/bin/env sh
# top-level bashrc; delegates to other configuration files

if [ -z "${XDG_CONFIG_HOME+x}" ]; then
    export XDG_CONFIG_HOME="${HOME}/.config"
fi

# this directory is ignored by git and is a safe place to put secret
# environment variables and such. Be cautious putting environment variables
# in here since they are often exported with bug reports.
# All non-hidden files in this directory will be sourced
if [ -d "${XDG_CONFIG_HOME}/bash/sourcing/" ]; then
    while read FOUND_SOURCING_FILE; do
        source "$FOUND_SOURCING_FILE"
    done < <(find -L "${XDG_CONFIG_HOME}/bash/sourcing/" -type f ! -name '.*')
    unset FOUND_SOURCING_FILE
fi

if ! pgrep "bash" | grep -q "$$"; then
    # shell is not bash; skipping configuration
    return
fi

# lines below this block will start failing shellcheck because it can't know that we're guaranteed bash from here on

shopt -s checkwinsize

shopt -s cmdhist
shopt -s histappend

export HISTCONTROL=ignoredups
export HISTFILESIZE=5000
export HISTSIZE=5000

export CLICOLOR=1
export EDITOR=vim

# grab all extra configurations
if [ -z "$PS1" ] || ! grep -q "i" <<< "$-"; then
    # shell is not interactive
    return
fi

__source_if_file_exists() {
    local FILENAME="$1"
    if [ -e "$FILENAME" ]; then
        source "$FILENAME"
    fi
}

if brew --prefix &>/dev/null; then
    if [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
        if [ -d "$(brew --prefix)/etc/bash_completion.d" ]; then
            BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
            export BASH_COMPLETION_COMPAT_DIR="$BASH_COMPLETION_COMPAT_DIR"
            __source_if_file_exists "$(brew --prefix)/share/bash-completion/bash_completion"
        fi
        source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
    fi
else
    __source_if_file_exists /etc/bash_completion
fi

if ! type -p __git_complete &>/dev/null; then
    if type -p _completion_loader &>/dev/null; then
        _completion_loader git
    fi
fi

# this directory is ignored by git and is a safe place to put configuration
# that shouldn't be in a public repository, like work items
__source_if_file_exists "${XDG_CONFIG_HOME}/bash/local_config/bashrc"

__source_if_file_exists "${XDG_CONFIG_HOME}/bash/prompt.sh"
__source_if_file_exists "${XDG_CONFIG_HOME}/bash/functions.sh"
__source_if_file_exists "${XDG_CONFIG_HOME}/bash/aliases.sh"

