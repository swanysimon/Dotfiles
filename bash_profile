#!/usr/local/bin/bash
# ~/.bash_profile
# Simon Swanson
# Last edited June 5, 2015

# enable autocompletion because homebrew bash
[[ -f $(brew --prefix)/etc/bash_completion ]] && . $(brew --prefix)/etc/bash_completion

# set environment
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'
export VISUAL=vim
export EDITOR=$VISUAL
export PS1="\u@{\W}\\$ "

[[ -f ~/.bashrc ]] && source ~/.bashrc
