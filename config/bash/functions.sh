#!/usr/bin/env bash

backup () {
    case "$1" in
        "")
            echo "No archive format chosen" 2<&1
            return 2 ;;
        -h|--help)
            echo "backup [ -h ] [ <archive_format> [ archive_name ] ] file1 ..."
            echo "Supported archive formats: bzip2, gzip, tar, tar.bz2, tar.gz, tar.xz, zip"
            echo "When no archive format is speicified, files and directories are copied in a .bak file"
            echo "If no archive name is given, the first file is used as the base of the archive name" ;;
        bz|bz2|bzip|bzip2)
            shift 1
            bzip2 -kv "$@" ;;
        gz|gzip)
            shift 1
            gzip -kv "$@" ;;
        tar)
            shift 1
            if [[ "$1" == *.tar ]]; then
                tar -cvf "$@"
            elif [[ -d "$1" ]];then
                tar -cvf "${1::-1}.tar" "$@"
            else
                tar -cvf "$1.tar" "$@"
            fi ;;
        tar.bz|tar.bz2|tbz|tbz2)
            local EXT="$1"
            shift 1
            if [[ "$1" == *.tar.bz2 || "$1" == *.tbz2 || "$1" == *.tar.bz || "$1" == *.tbz ]]; then
                tar -cjvf "$@"
            elif [[ -d "$1" ]]; then
                tar -cjvf "${1::-1}.${EXT}" "$@"
            else
                tar -cjvf "$1.${EXT}" "$@"
            fi ;;
        tar.gz|tgz)
            local EXT="$1"
            shift 1
            if [[ "$1" == *.tar.gz || "$1" == *.tgz ]]; then
                tar -czvf "$@"
            elif [[ -d "$1" ]]; then
                tar -czvf "${1::-1}.${EXT}" "$@"
            else
                tar -czvf "$1.${EXT}" "$@"
            fi ;;
        tar.xz|txz)
            local EXT="$1"
            shift 1
            if [[ "$1" == *tar.xz || "$1" == *.txz ]]; then
                tar -cJvf "$@"
            elif [[ -d "$1" ]]; then
                tar -cJvf "${1::-1}.${EXT}" "$@"
            else
                tar -cJvf "$1.${EXT}" "$@"
                fi ;;
        zip)
            shift 1
            if [[ "$1" == *.zip ]]; then
                zip -rv "$@"
            elif [[ -d "$1" ]]; then
                zip -rv "${1::-1}.zip" "$@"
            else
                zip -rv "$1.zip" "$@"
            fi ;;
        *|bak)
            local ARG
            for ARG in "$@"; do
                if [[ -d "$ARG" ]]; then
                    cp -Riv "$ARG" "${ARG::-1}.bak"
                else
                    cp -iv "$ARG" "${ARG}.bak"
                fi
            done ;;
    esac
}

# unarchive a file
extract () {
    local ARG
    for ARG in "$@"; do
        case "$ARG" in
            -h|--help|help)
                echo "extract [ -h ] archive1 ..."
                echo "Supported formats are: bzip2, gzip, lzma, tar, xz, Z, zip"
                return 0 ;;
            *)
                if [[ ! -f "$ARG" ]]; then
                    echo "$ARG: no such file or directory" 2>&1
                    return 2
                fi
        esac
    done
    for ARG in "$@"; do
        case "$ARG" in
            *.tar.bz|*.tar.bz2|*.tbz|*.tbz2)
                tar -xjf "$ARG" ;;
            *.tar.gz|*.tgz)
                tar -xzf "$ARG" ;;
            *.tar.xz|*.txz)
                tar -xJf "$ARG" ;;
            *.bz|*.bz2|*.bzip|*.bzip2)
                bunzip2 "$ARG" ;;
            *.gz)
                gunzip "$ARG" ;;
            *.lzma|*.xz)
                unlzma "$ARG" ;;
            *.tar)
                tar -xf "$ARG" ;;
            *.Z)
                uncompress "$ARG" ;;
            *.zip)
                unzip "$ARG" ;;
            *)
                echo "$ARG: unknown archive format" 2>&1 ;;
        esac
    done
}

# find out what's happening on a port
port () {
    local COMMAND
    if [ "$(uname)" == "Darwin" ]; then
        COMMAND="lsof -i :$1 -P"
    elif [ "$(uname)" == "Linux" ]; then
        COMMAND="netstat -nlp | grep :$1"
    else
        echo "Unknown system $(uname)" 2>&1
        return 1
    fi
    echo "Running '${COMMAND}'"
    eval $COMMAND
}
