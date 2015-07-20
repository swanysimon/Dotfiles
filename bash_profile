#!/usr/local/bin/bash
# bash_profile
# Simon Swanson

# enable autocompletion because homebrew bash
[[ -f $(brew --prefix)/etc/bash_completion ]] && . $(brew --prefix)/etc/bash_completion

# export history entries
shopt -s histappend

# set environment
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'
export VISUAL=vim
export EDITOR=$VISUAL
export PS1="\u@{\W}\\$ "
export HISTCONTROL=ignoredups:erasedups
export PROMPT_COMMAND="history -a ; history -c ; history -r ; $PROMPT_COMMAND"
export HOMEBREW_CASK_OPTS='--appdir=/Applications'

[[ -f ~/.bashrc ]] && source ~/.bashrc
