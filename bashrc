# bashrc
# Simon Swanson
# sets up my bash aliases and functions

# if not running interactively do nothing
[[ $- != *i* ]] && return

# su stops being so stupid
alias su='sudo -i'

# editor shortcut
alias vi='vim'
alias edit='vim'

# navigation shortcuts
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias back='cd $OLDPWD'
alias ls='ls -F'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ll -a'

# filesystem safety
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -pv'

# gradle
alias gw='./gradlew --daemon'

# activity monitoring
alias top='top -o cpu'

# drive ejection
alias eject='hdiutil eject'

# stupid wifi
alias airport='networksetup -setairportpower en0'
alias toggle='airport off; airport on'
alias ping='ping -c 10'

# power button aliases
alias shutdown='sudo shutdown -h now'
alias restart='sudo shutdown -r now'
alias sleepytime='sudo shutdown -s now; sudo -k'

# random text editing
function finagle() {
    case "$1" in 
        "")   vim ~/.finagle;;
	    e|-e) open -e ~/.finagle;;
	    *)    echo "$FUNCNAME: unknown arguments \"$@\""
    esac
}

# for sanity's sack while backing things up
function backup() {
    local USAGE=$'usage: '$FUNCNAME$' [help | archive format] [<file> ...]\nAll variations of bzip2, gzip, xz, and zip compression support compression level support:\n -1 --fast \t fastest (worst compression)\n ...\n -9 --best \t slowest (best) compression'
    case "$1" in
        "") 
            echo "$FUNCNAME: no file specified"
            echo "$USAGE"
            ;;
        h|help|-h|-help|--help) 
            echo "$USAGE"
            ;;
        bz2|bz|bzip2|bzip)
            shift
            bzip2 -kv "$@"
            ;;
        gz|gzip)
            shift
            gzip -kv "$@"
            ;;
        lzma)
            shift
            lzma -zkv "$@"
            ;;
        xz)
            shift
            xz -zkvF xz "$@"
            ;;
        zip)
            shift
            if [[ "$1" == *.zip ]]; then
                zip -rv "$@"
            elif [[ -d "$1" ]]; then
                zip -rv "${1::-1}.zip" "$@" 
            else
                zip -rv "$1.zip" "$@"
            fi
            ;;
        tar|tarball)
            shift
            if [[ "$1" == *.tar ]]; then
                tar -cvf "$@"
            elif [[ -d "$1" ]];then
                tar -cvf "${1::-1}.tar" "$@"
            else
                tar -cvf "$1.tar" "$@"
            fi
            ;;
        tar.bz2|tbz2|tar.bz|tbz) 
            local EXT="$1"
            shift
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
	    shift
	    if [[ "$1" == *.tar.gz || "$1" == *.tgz ]]; then
                tar -czvf "$@"
            elif [[ -d "$1" ]]; then
                tar -czvf "${1::-1}.${EXT}" "$@"
            else
                tar -czvf "$1.${EXT}" "$@"
            fi
	    ;;
	* ) 
	    if [[ -e $1 ]]; then
                for F in "$@"; do
                    if [[ -f "$F" ]]; then
                        cp -iv "$F" "${F}.bak"
                    elif [[ -d "$F" ]]; then
                        cp -Riv "$F" "${F::-1}.bak/"
                    else
                        echo "$FUNCNAME: $F: no such file or directory"
                        exit 2
                    fi
                done
            else
                echo "$FUNCNAME: $1: unknown archive format"
                echo "$USAGE"
            fi
            ;;
    esac
}
