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
export GREP_OPTIONS='--color=auto'

if [[ -f "$(brew --prefix 2> /dev/null)/etc/bash_completion" ]]; then
    . "$(brew --prefix 2> /dev/null)/etc/bash_completion"
fi

# grab all extra configurations
[[ -z "$PS1" || $- != *i* ]] && return

[[ -f "${HOME}/.bash_config/bash_prompt" ]] && source "${HOME}/.bash_config/bash_prompt"
[[ -f "${HOME}/.bash_config/bash_functions" ]] && source "${HOME}/.bash_config/bash_functions"
[[ -f "${HOME}/.bash_config/bash_aliases" ]] && source "${HOME}/.bash_config/bash_aliases"
[[ -f "${HOME}/.bash_local_config/bashrc" ]] && source "${HOME}/.bash_local_config/bashrc"

