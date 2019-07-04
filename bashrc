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

# grab all extra configurations
if [ -z "$PS1" ] || ! grep -q "i" <<< "$-"; then
    # shell is not interactive
    return
fi

export CLICOLOR=1
export EDITOR=vim

if [ -z ${XDG_CONFIG_HOME+x} ]; then
    export XDG_CONFIG_HOME="${HOME}/.config"
fi

if [ -f "${XDG_CONFIG_HOME}/bash/bash_prompt" ]; then
    source "${XDG_CONFIG_HOME}/bash/bash_prompt"
fi

if [ -f "${XDG_CONFIG_HOME}/bash/bash_functions" ]; then
    source "${XDG_CONFIG_HOME}/bash/bash_functions"
fi

if [ -f "${XDG_CONFIG_HOME}/bash/bash_aliases" ]; then
    source "${XDG_CONFIG_HOME}/bash/bash_aliases"
fi

# this directory is ignored by git and is a safe place to put configuration
# that shouldn't be in a public repository, like work items
if [ -f "${XDG_CONFIG_HOME}/bash/local_config/bashrc" ]; then
    source "${XDG_CONFIG_HOME}/bash/local_config/bashrc"
fi

# this directory is ignored by git and is a safe place to put secret
# environment variables and such
# be cautious putting environment variables in here since they are often
# exported with bug reports.
if [ -d "${XDG_CONFIG_HOME}/bash/sourcing/" ]; then
    for file in "${XDG_CONFIG_HOME}/bash/sourcing/"*; do
        source "$file"
    done
fi

if brew --prefix &>/dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion"
fi

if ! type -p __git_complete &>/dev/null && type -p _completion_loader &>/dev/null; then
    _completion_loader git
fi

