#!/usr/bin/env bash

# better reading
alias less='less -r'
alias vi='vim'

# random
alias finagle='vim ~/.finagle'

# navigation
alias back='cd -'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ls='ls -hF'
alias la='ls -A'
alias ll='ls -l'
alias lla='ll -A'

# filesystem safety
alias cp='cp -vi'
alias mv='mv -vi'
alias rm='rm -vi'
alias mkdir='mkdir -pv'

# git aliases
alias g='git'
if type -p _git &>/dev/null; then
    if type -p __git_complete &>/dev/null; then
        __git_complete g _git
    elif ! complete -o default -o nospace -F _git g &>/dev/null; then
        complete -o bashdefault -o default -o nospace -F _git g &>/dev/null
    fi
fi

# fuck. it's a little slow but still usefull
if which thefuck &>/dev/null; then
    eval "$(thefuck --alias)"
fi

# clipboards commands synchronized to the Mac OS standard
if [ "$(uname)" == "Linux" ]; then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
fi
