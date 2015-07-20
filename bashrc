#!/usr/local/bin/bash
# bashrc
# Simon Swanson

# if not running interactively do nothing
[[ $- != *i* ]] && return

# open my standard tmux session on startup
[[ -z "$TMUX" ]] && [[ $(command -v tmux) ]] && tmux new -As main

# editor shortcut
alias vi='vim'
alias edit='vim'

# ls variations
alias ls='ls -F'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ll -a'

# navigation shortcuts
alias back='cd $OLDPWD'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'

# filesystem modification aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'

# activity monitoring
alias top='top -o cpu'
alias psg='ps aux | grep -v "grep -i -e VXZ -e" | grep -i -e VXZ -e'

# drive ejection
alias eject='hdiutil eject'

# stupid wifi
alias airport='networksetup -setairportpower en1'
alias toggle='airport off; airport on'
alias ping='ping -c 10'

# power button aliases
alias shutdown='sudo shutdown -h now'
alias restart='sudo shutdown -r now'
alias sleepytime='sudo shutdown -s now; sudo -k'

# mplayer shortcuts
alias mplayer='mplayer -fs'
alias play='mplayer -really-quiet'

# random text editing
function finagle() {
    if [[ -z $1 ]]; then
        vim ~/.finagle
    elif [[ $1 -eq "-e" ]]; then
        open -e ~/.finagle
    else
        echo "$FUNCNAME: unknown arguments \"$@\""
    fi
}

# quick compression function
function backup() {
    local USAGE=$'usage: '$FUNCNAME$' [help | archive format] [<file> ...]\nAll variations of bzip2, gzip, xz, and zip compression support compression level support:\n -1 --fast \t fastest (worst compression)\n ...\n -9 --best \t slowest (best) compression'
    case $1 in
        ""               ) echo "$FUNCNAME: no file specified" ; echo "$USAGE" ;;
        h|help           ) echo "$USAGE" ;;
        bz2|bz|bzip2|bzip) shift ; bzip2 -kv "$@" ;;
        gz|gzip          ) shift ; gzip -kv "$@" ;;
        lzma             ) shift ; lzma -zkv "$@" ;;
        xz               ) shift ; xz -zkvF xz "$@" ;;
        zip              ) shift ; [[ "$1" == *.zip ]] && zip -rv "$@" || zip -rv "${1::-1}.zip" "$@" ;;
        tar|tarball      ) shift ; [[ "$1" == *.tar ]] && tar -cvf "$@" || tar -cvf "${1::-1}.tar" "$@" ;;
        tar.bz2|tbz2|tar.bz|tbz) 
            local EXT="$1"
            shift
            [[ "$1" == *.tar.bz2 || "$1" == *.tbz2 || "$1" == *.tar.bz || "$1" == *.tbz ]] && tar -cjvf "$@" || tar -cjvf "${1::-1}.${EXT}" "$@"
            ;;
        tar.gz|tgz)
            local EXT="$1"
            shift
            [[ "$1" == *.tar.gz || "$1" == *.tgz ]] && tar -czvf "$@" || tar -czvf "${1::-1}.${EXT}" "$@"
            ;;
        *) if [[ -f "$1" || -d "$1" ]]; then
            for F in "$@"; do
                if [[ -f "$F" ]]; then
                    cp -iv "$F" "${F}.bac"
                elif [[ -d "$F" ]]; then
                    cp -Riv "$F" "${F::-1}.bak/"
                else
                    echo "$F is not a file or directory"
                fi
            done
        else
            echo "Unknown archive format \"$1\""
            echo "$USAGE"
        fi ;;
    esac
}

function orf() {
    [[ -z $1 ]] && local DIR=. || local DIR=$1
    local TMP=$(mktemp ~/.tmpXXX)
    trap "rm -f $TMP" 1 2 9 15
    find $DIR \! -path "*/.*" -type f \! -name ".*" -maxdepth 1 > $TMP
    local RAND=$(jot -r 1 1 $(cat $TMP | wc -l))
    local i=1
    while read LINE; do
        if [[ $i -eq $RAND ]]; then
            echo "Opening $LINE"
            open "$LINE"
            break
        else
            i=$i+1
        fi
    done < $TMP
    rm -f $TMP
}

function sizeof() {
    if [[ -z $1 ]]; then
        du -d 1 -h
    else
        while [[ $1 ]]; do
            if [[ -d $1 ]]; then
                du -d 0 -h $1
            else
                \ls -lh $1 | awk '{ printf " %s\t", $5 } END { for (i = 9; i <= NF; i++) print $i }'
            fi
            shift
        done
    fi
}
