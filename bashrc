#!/usr/bin/env bash
# bashrc

shopt -s checkwinsize

shopt -s histappend
shopt -s histreedit
shopt -s histverify

export HISTCONTROL=ignoredupbs:erasedups
export HISTFILESIZE=5000
export HISTSIZE=5000

export EDITOR=vim

export CLICOLOR=1

if [ -f "$(brew --prefix 2> /dev/null)/etc/bash_completion" ]; then
    source "$(brew --prefix 2> /dev/null)/etc/bash_completion"
fi

if ! type -p __git_complete > /dev/null; then
    _completion_loader git
fi

# grab all extra configurations
if [[ -z "$PS1" || $- != *i* ]]; then
    return
fi

if [ -f "${HOME}/.bash_config/bash_prompt" ]; then
    source "${HOME}/.bash_config/bash_prompt"
fi

if [ -f "${HOME}/.bash_config/bash_functions" ]; then
    source "${HOME}/.bash_config/bash_functions"
fi

if [ -f "${HOME}/.bash_config/bash_aliases" ]; then
    source "${HOME}/.bash_config/bash_aliases"
fi

if [ -f "${HOME}/.bash_local_config/bashrc" ]; then
    source "${HOME}/.bash_local_config/bashrc"
fi

