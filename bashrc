# bashrc
# Simon Swanson
# sets up my bash aliases and functions

# if not running interactively do nothing
[[ $- != *i* ]] && return

# su stops being so stupid
alias su='sudo -i'
alias exit='[[ "$(sudo -n echo "x" 2> /dev/null)" ]] && sudo -k || exit'
alias logout='[[ "$(sudo -n echo "x" 2> /dev/null)" ]] && sudo -k || exit'

# editor shortcuts
alias edit='vim'
alias less='less -r'
alias vi='vim'

# navigation shortcuts
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias back='cd $OLDPWD'
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
alias pull='git fetch && git rebase'
alias push='git push'
alias ga='git add'
alias gb='git branch'
alias gd='git diff'
alias gf='git fetch'
alias gh='git-home'
alias gk='git checkout'
alias gl='git log --abbrev-commit --date=short --decorate --graph --pretty=format:"%h %C(yellow)%ad %C(reset)- %C(green)%an%C(reset)%n%w(0,8,8)%B"'
alias gls='git diff-tree --name-status --no-commit-id -r'
alias go='git commit'
alias grb='git rebase'
alias gs='git status'

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

# for sanity's sack while backing things up
function backup() {
    local USAGE
    read -d '' USAGE <<EOF
USAGE: backup [ help ] [ format [archive_name] [format_options]] [ <file1 | directory1> ... ]
Supported archive formats are: bak, bzip2, gzip, zip, tar
For an empty archive format or 'bak', files and directories are rename to have a '.bak' extension
For all other archive formats, the first optional argument to the format is the name of the archive to create. 
    



If achive format is ommitted, all files are renamed with a '.bak' extension

All variations of bzip2, gzip, xz, and zip compression support compression level support:
  -1 --fast \t fastest (worst compression)
    ...
  -9 --best \t slowest (best) compression
EOF
    case "$1" in
        "") 
            echo "backup: no file or directory to back up" 1>&2
            echo "$USAGE" 1>&2
            return 2
            ;;
        help|-h|--help) 
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
        bak|*) 
            [[ "$1" == "bak" ]] && shift 1
            if [[ -d "$1" || -f "$1" ]]; then
                for F in "$@"; do
                    if [[ -f "$F" ]]; then
                        cp -iv "$F" "${F}.bak"
                    elif [[ -d "$F" ]]; then
                        cp -Riv "$F" "${F::-1}.bak/"
                    else
                        echo "backup: $F: no such file or directory" 1>&2
                        return 2
                    fi
                done
            else
                echo "backup: $1: no such file or directory" 1>&2
                echo "$USAGE" 1>&2
                return 2
            fi
            ;;
    esac
}

function brew() {
    if [[ ! -w /usr/local/share/ || ! -w /usr/local/bin ]]; then
        echo "Giving correct permissions to /usr/local/share/ and /usr/local/bin/ for brew operations"
        sudo chown -R $(whoami) /usr/local/share
        sudo chown -R $(whoami) /usr/local/bin
    fi
    sudo -k
    case "$1" in
        update)
            case "$2" in
                -a|--all)
                    brew update
                    local USTATUS=$?
                    [[ $USTATUS -ne 0 ]] && return $USTATUS
                    brew upgrade --all
                    for i in $(brew cask list); do
                        if [[ "$(brew cask info "$i" | grep -x "Not installed")" ]]; then
                            brew cask install --force "$i"
                        else
                            echo "$i is already up-to-date"
                        fi
                    done
                    ;;
                *)
                    /usr/local/bin/brew $@
                    ;;
            esac
            ;;
        *)
            /usr/local/bin/brew $@
            ;;
    esac
}

function extract() {
    local USAGE=$'usage: '$0$' [help | 
Supported formats include: bzip2, gzip, lzma, tar, xz, Z, zip'
    local FILEERROR="$0: $1: no such file or directory"
    local ARCHIVEERROR="$0: $1: unknown archive format"
    [[ "-h" = "$1" || "--help" = "$1" ]] && echo "$USAGE" 1>&2 && return 1
    [[ ! -f "$1" ]] && echo "$FILEERROR" 1>&2 && return 1
    case "$1" in
        *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) tar xjvf "$1"   ;;
        *.tar.gz|*.tgz)                  tar xzvf "$1"   ;;
        *.bz|*.bz2|*.bzip|*.bzip2)       bunzip2 "$1"    ;;
        *.gz)                            gunzip "$1"     ;;
        *.lzma)                          unlzma "$1"     ;;
        *.tar)                           tar xvf "$1"    ;;
        *.xz)                            unxz "$1"       ;;
        *.Z)                             uncompress "$1" ;;
        *.zip)                           unzip "$1"      ;;
        *)
            echo "$ARCHIVEERROR" 1>&2
            echo "$USAGE" 1>&2
            return 2
            ;;
    esac
}

# random text editing
function finagle() {
    case "$1" in 
        "")
            vim ~/.finagle
            ;;
        e|-e)
            open -e ~/.finagle
            ;;
        *)
            echo "$0: unknown arguments \"$@\"" 1>&2
            return 1
            ;;
    esac
}

# fixes permission problems I encounter frequently enough
function permissionFix() {
    sudo chflags -R nouchg "$1"
    sudo chown -R $(whoami) "$1"
    sudo chmod -R 755 "$1"
    sudo -k
    find "$1" -type f -print0 | xargs -0 chmod 644
}

