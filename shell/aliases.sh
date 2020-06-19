#!/bin/sh

alias less="less -r"
alias vi="vim"

alias finagle="vim ~/.finagle"

alias back="cd -"
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias ls="ls -hF"
alias la="ls -A"
alias ll="ls -l"
alias lla="ll -A"

alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -vi"
alias mkdir="mkdir -pv"

alias g="git"

alias gw="./gradlew"

if command -v thefuck >/dev/null; then
    eval "$(thefuck --alias)"
fi
