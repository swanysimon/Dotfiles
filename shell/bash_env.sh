#!/usr/bin/env bash
# manages the bash environment

export HISTCONTROL=ignoredups
export HISTFILESIZE=5000
export HISTSIZE=5000

export CLICOLOR=1
export EDITOR=vim

shopt -s checkwinsize
shopt -s cmdhist
shopt -s histappend

if [ -z "$XDG_CONFIG_HOME" ]; then
  export XDG_CONFIG_HOME="${HOME}/.config"
fi

if [ -z "$XDG_DATA_HOME" ]; then
  export XDG_DATA_HOME="${HOME}/.local/share"
fi

if [ -z "$XDG_DATA_DIRS" ]; then
  export XDG_DATA_DIRS="/usr/local/share:/usr/share"
fi

if [ -z "$XDG_CONFIG_DIRS" ]; then
  export XDG_DATA_DIRS="/etc/xdg"
fi

if [ -z "$XDG_CACHE_HOME" ]; then
  export XDG_CACHE_HOME="${HOME}/.cache"
fi

THIS_FILE="$(__physical_file "${BASH_SOURCE[0]}")"
DOTFILES_DIR="$(git rev-parse --show-toplevel -C "$(dirname "$THIS_FILE")")"
export DOTFILES_DIR
unset THIS_FILE
