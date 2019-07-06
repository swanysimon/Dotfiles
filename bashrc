# top-level bashrc; delegates to other configuration files

if ! ps -p "$$" -o command= | grep -q "bash$"; then
    # shell is not bash; skipping configuration
    return
fi

shopt -s checkwinsize

shopt -s histappend
shopt -s cmdhist

export HISTCONTROL=ignoredupbs:erasedups
export HISTFILESIZE=5000
export HISTSIZE=5000
export HISTIGNORE="ls:bg:fg:history"

export CLICOLOR=1
export EDITOR=vim

if [ -z ${XDG_CONFIG_HOME+x} ]; then
    export XDG_CONFIG_HOME="${HOME}/.config"
fi

# grab all extra configurations
if [ -z "$PS1" ] || ! grep -q "i" <<< "$-"; then
    # shell is not interactive
    return
fi

__source_if_file_exists() {
    local FILENAME="$1"
    if [ -f "$FILENAME" ]; then
        source "$FILENAME"
    fi
}

__source_if_file_exists "${XDG_CONFIG_HOME}/bash/bash_prompt"
__source_if_file_exists "${XDG_CONFIG_HOME}/bash/bash_functions"
__source_if_file_exists "${XDG_CONFIG_HOME}/bash/bash_aliases"

# this directory is ignored by git and is a safe place to put configuration
# that shouldn't be in a public repository, like work items
__source_if_file_exists "${XDG_CONFIG_HOME}/bash/local_config/bashrc"

# this directory is ignored by git and is a safe place to put secret
# environment variables and such. Be cautious putting environment variables
# in here since they are often exported with bug reports.
# All non-hidden files in this directory will be sourced
if [ -d "${XDG_CONFIG_HOME}/bash/sourcing/" ]; then
    find . ! -name '.*' -type f -exec source {} \;
fi

if brew --prefix &>/dev/null; then
    __source_if_file_exists "$(brew --prefix)/etc/bash_completion"
fi

if ! type -p __git_complete &>/dev/null && type -p _completion_loader &>/dev/null; then
    _completion_loader git
fi

