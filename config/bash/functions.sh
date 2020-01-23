#!/usr/bin/env bash

# archive up a file or directory with the given format
backup () {
    declare EXT
    case "$1" in
        -h|--help)
            echo "backup [ -h ] [ <archive_format> [ archive_name ] ] file1 ..."
            echo "Supported archive formats: bzip2, gzip, tar, tar.bz2, tar.gz, tar.xz, zip"
            echo "When no archive format is speicified, files and directories are copied in a .bak file"
            echo "If no archive name is given, the first file is used as the base of the archive name" ;;
        bz|bz2|bzip|bzip2)
            shift 1
            bzip2 -kv "$@"
            ;;
        gz|gzip)
            shift 1
            gzip -kv "$@"
            ;;
        tar)
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
            EXT="$1"
            shift 1
            if egrep -q "\.tar\.bz2$|\.tbz2$|\.tar\.bz$|\.tbz$" <<< "$1"; then
                tar -cjvf "$@"
            elif [ -d "$1" ]; then
                tar -cjvf "${1::-1}.${EXT}" "$@"
            else
                tar -cjvf "$1.${EXT}" "$@"
            fi
            ;;
        tar.gz|tgz)
            EXT="$1"
            shift 1
            if egrep -q "\.tar\.gz$|\.tgz$" <<< "$1"; then
                tar -czvf "$@"
            elif [ -d "$1" ]; then
                tar -czvf "${1::-1}.${EXT}" "$@"
            else
                tar -czvf "$1.${EXT}" "$@"
            fi
            ;;
        tar.xz|txz)
            EXT="$1"
            shift 1
            if egrep -q "\.tar\.xz$|\.txz$" <<< "$1"; then
                tar -cJvf "$@"
            elif [ -d "$1" ]; then
                tar -cJvf "${1::-1}.${EXT}" "$@"
            else
                tar -cJvf "$1.${EXT}" "$@"
            fi
            ;;
        zip)
            shift 1
            if grep -q "\.zip$" <<< "$1"; then
                zip -rv "$@"
            elif [ -d "$1" ]; then
                zip -rv "${1::-1}.zip" "$@"
            else
                zip -rv "$1.zip" "$@"
            fi
            ;;
        ""|bak)
            declare ARG
            for ARG in "$@"; do
                if [ -d "$ARG" ]; then
                    cp -Riv "$ARG" "${ARG::-1}.bak/"
                else
                    cp -iv "$ARG" "${ARG}.bak"
                fi
            done
            ;;
    esac
}

# unarchive a file
extract () {
    declare ARG
    for ARG in "$@"; do
        case "$ARG" in
            *.tar.bz|*.tar.bz2|*.tbz|*.tbz2)
                tar -xjf "$ARG"
                ;;
            *.tar.gz|*.tgz)
                tar -xzf "$ARG"
                ;;
            *.tar.xz|*.txz)
                tar -xJf "$ARG"
                ;;
            *.bz|*.bz2|*.bzip|*.bzip2)
                bunzip2 "$ARG"
                ;;
            *.gz)
                gunzip "$ARG"
                ;;
            *.tar)
                tar -xf "$ARG"
                ;;
            *.zip)
                unzip "$ARG"
                ;;
            *)
                echo "$ARG: unknown archive format" 2>&1
                ;;
        esac
    done
}

# mini-alias for gradle commands
gw () {
    declare ARG
    declare -i OPTIND=1

    declare -a COMMAND=( './gradlew' )
    while getopts ":cC:oP:-:" OPT; do
        case "$OPT" in
            c)
                COMMAND+=( 'compileJava' 'compileTestJava' )
                ;;
            C)
                COMMAND+=( ":${OPTARG}:compileJava" ":${OPTARG}:compileTestJava" )
                ;;
            o)
                COMMAND+=( '--offline' )
                ;;
            P)
                COMMAND+=( "-P${OPTARG}" )
                ;;
            -)
                COMMAND+=( "--$OPTARG" )
                ;;
            \?)
                COMMAND+=( "-$OPTARG" )
                ;;
        esac
    done
    shift $((OPTIND-1))

    COMMAND=( "${COMMAND[@]}" "$@" )
    echo "Running '${COMMAND[*]}'..."
    "${COMMAND[@]}"
}

# find out what's happening on a port
port () {
    if [ "$(uname)" == "Darwin" ]; then
        lsof -i :"$1" -P
        return $?
    elif [ "$(uname)" == "Linux" ]; then
        netstat -nlp | grep :"$1"
        return $?
    fi

    echo "Unknown system $(uname -a)" 2>&1
    return 1
}

