# bashrc
# Simon Swanson
# sets up my bash aliases and functions

# if not running interactively do nothing
[[ $- != *i* ]] && return

# su stops being so stupid
alias su='sudo -i'
alias exit='sudo -n echo "" 2> /dev/null && sudo -k || exit'
alias logout='sudo -n echo "" 2> /dev/null && sudo -k || exit'

# editor shortcuts
alias edit='vim'
alias less='less -r'
alias macvim='open -a macvim'
alias vi='vim'

# navigation shortcuts
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
alias df='df -h'
alias du='du -h'

# for common mistakes
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'

# short git shortcuts
alias git-home='cd $(git rev-parse --show-toplevel)'
alias fetch='git fetch'
alias merge='git merge'
alias pull='git pull --stat'
alias push='git push'
alias ga='git add'
alias gb='git branch'
alias gd='git diff'
alias gf='git fetch'
alias gh='git-home'
alias gk='git checkout'
alias gl='git log --graph --pretty=format:"%h %C(yellow)%ad %C(reset)- %C(green)%an%C(reset)%n%w(0,8,8)%B"'
alias glv='gl --stat-graph-width=$((${COLUMNS}/8))'
alias go='git commit'
alias grb='git rebase'
alias gs='git status -s'

# activity monitoring
alias top='top -o cpu'

# drive ejection
alias eject='hdiutil eject'

# stupid wifi
alias airport='networksetup -setairportpower en0'
alias toggle='airport off && airport on'
alias ping='ping -c 10'

# power button aliases
alias shutdown='sudo shutdown -h now'
alias restart='sudo shutdown -r now'
alias sleepytime='sudo shutdown -s now; sudo -k'

# a sane way to archive things
function backup() {
    local USAGE=$'usage: backup [ help ] [ format [archive_name] ] file1 file2...
Supported archive formats are: bzip2, gzip, zip, tar, tar.bz2, tar.gz
When no archive format is specified, files and directories are renamed to have a .bak extension
If an unknown format is specified, file and directories are renamed to have the unknown format as an extension
If an archive name is not given, the first file is used as the base of the new filename'
    case "$1" in
        "")
            echo "$USAGE" 1>&2
            return 2
            ;;
        -h|help|-help|--help)
            echo "$USAGE"
            return 0
            ;;
        bz|bz2|bzip|bzip2)
            shift 1
            bzip2 -kv "$@"
            ;;
        gz|gzip)
            shift 1
            gzip -kv "$@"
            ;;
        tar|tarball)
            shift 1
            if [[ "$1" == *.tar ]]; then
                tar -cvf "$@"
            elif [[ -d "$1" ]];then
                tar -cvf "${1::-1}.tar" "$@"
            else
                tar -cvf "$1.tar" "$@"
            fi
            ;;
        tar.bz|tar.bz2|tbz|tbz2)
            local EXT="$1"
            shift 1
            if [[ "$1" == *.tar.bz2 || "$1" == *.tbz2 || "$1" == *.tar.bz || "$1" == *.tbz ]]; then
                tar -cjvf "$@"
            elif [[ -d "$1" ]]; then
                tar -cjvf "${1::-1}.${EXT}" "$@"
            else
                tar -cjvf "$1.${EXT}" "$@"
            fi
            ;;
        tar.gz|tgz)
            local EXT="$1"
            shift 1
            if [[ "$1" == *.tar.gz || "$1" == *.tgz ]]; then
                tar -czvf "$@"
            elif [[ -d "$1" ]]; then
                tar -czvf "${1::-1}.${EXT}" "$@"
            else
                tar -czvf "$1.${EXT}" "$@"
            fi
            ;;
        zip)
            shift 1
            if [[ "$1" == *.zip ]]; then
                zip -rv "$@"
            elif [[ -d "$1" ]]; then
                zip -rv "${1::-1}.zip" "$@"
            else
                zip -rv "$1.zip" "$@"
            fi
            ;;
        *)
            if [[ ! -d "$1" && ! -f "$1" ]]; then
                local extension="$1"
                shift 1
            fi
            if [[ $# -eq 0 ]]; then
                echo "backup: no file or directory to back up" 1>&2
                echo "$USAGE" 1>&2
                return 1
            fi
            local file
            for file in "$@"; do
                if [[ -f "$file" ]]; then
                    cp -iv "$file" "${file}.${extension-bak}"
                elif [[ -d "$file" ]]; then
                    cp -Riv "$file" "${file::-1}.${extension-bak}/"
                else
                    echo "backup: $file: no such file or directory. Continuing to next file" 1>&2
                fi
            done
            ;;
    esac
}

# change cd to become silent pushd/popd
function cd() {
    case "$1" in
        "$PWD") ;;
        -*)
            if [[ "$1" =~ ^-[0-9]+$ ]]; then
                for i in {1...${1}}; do
                    popd > /dev/null
                done
            else
                popd > /dev/null
            fi
            ;;
        *)
            if [[ -z "$1" ]]; then
                pushd "$HOME" > /dev/null
            else
                pushd "$@" > /dev/null
            fi
            ;;
    esac
}

# unarchive a file
function extract() {
    local USAGE=$'usage: extract [ help ] archive1 archive2 ...
Supported formats include: bzip2, gzip, lzma, tar, xz, Z, zip'
    case "$1" in
        -h|help|-help|--help)
            echo "$USAGE"
            return 0
            ;;
        *)
            local arg
            for arg in "$@"; do
                local FILEERROR="extract: $arg: no such file or directory"
                local ARCHIVEERROR="extract: $arg: unknown archive format"
                [[ ! -f "$arg" ]] && echo "$FILEERROR" 1>&2 && return 1
                case "$arg" in
                    *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) tar -xjf "$arg"   ;;
                    *.tar.gz|*.tgz)                  tar -xzf "$arg"   ;;
                    *.bz|*.bz2|*.bzip|*.bzip2)       bunzip2 "$arg"    ;;
                    *.gz)                            gunzip "$arg"     ;;
                    *.lzma)                          unlzma "$arg"     ;;
                    *.tar)                           tar -xf "$arg"    ;;
                    *.xz)                            unxz "$arg"       ;;
                    *.Z)                             uncompress "$arg" ;;
                    *.zip)                           unzip "$arg"      ;;
                    *)
                        echo "$ARCHIVEERROR" 1>&2
                        echo "$USAGE" 1>&2
                        return 2
                        ;;
                esac
            done
    esac
    echo "$USAGE" 1>&2
    return 1
}

# random text editing
function finagle() {
    case "$1" in
        "") vim ~/.finagle ;;
        e|-e) open -e ~/.finagle ;;
        *)
            echo "$0: unknown arguments \"$@\"" 1>&2
            return 1
            ;;
    esac
}

# find out what's happening on a port
function port() {
    if [[ $# -eq 0 ]]; then
        lsof -iSTP -P | grep LISTEN
    else
        local port
        for port in "$@"; do
            local command="lsof -iTCP -P | grep LISTEN | grep $port"
            echo "$command"
            eval "$command"
        done
    fi
}

