#!/usr/bin/env bash

backup () {
  declare EXTENSION
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
      EXTENSION="$1"
      shift 1
      if grep -E -q "\.tar\.bz2$|\.tbz2$|\.tar\.bz$|\.tbz$" <<< "$1"; then
        tar -cjvf "$@"
      elif [ -d "$1" ]; then
        tar -cjvf "${1::-1}.${EXTENSION}" "$@"
      else
        tar -cjvf "$1.${EXTENSION}" "$@"
      fi
      ;;
    tar.gz|tgz)
      EXTENSION="$1"
      shift 1
      if grep -E -q "\.tar\.gz$|\.tgz$" <<< "$1"; then
        tar -czvf "$@"
      elif [ -d "$1" ]; then
        tar -czvf "${1::-1}.${EXTENSION}" "$@"
      else
        tar -czvf "$1.${EXTENSION}" "$@"
      fi
      ;;
    tar.xz|txz)
      EXTENSION="$1"
      shift 1
      if grep -E -q "\.tar\.xz$|\.txz$" <<< "$1"; then
        tar -cJvf "$@"
      elif [ -d "$1" ]; then
        tar -cJvf "${1::-1}.${EXTENSION}" "$@"
      else
        tar -cJvf "$1.${EXTENSION}" "$@"
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
      declare FILE
      for FILE in "$@"; do
        if [ -d "$FILE" ]; then
          cp -Riv "$FILE" "${FILE::-1}.bak/"
        else
          cp -iv "$FILE" "${FILE}.bak"
        fi
      done
      ;;
  esac
}

# unarchive a file
extract () {
  declare ARCHIVE
  declare -i EXIT_CODE
  EXIT_CODE=0
  for ARCHIVE in "$@"; do
    case "$ARCHIVE" in
      *.tar.bz|*.tar.bz2|*.tbz|*.tbz2)
        tar -xjf "$ARCHIVE"
        ;;
      *.tar.gz|*.tgz)
        tar -xzf "$ARCHIVE"
        ;;
      *.tar.xz|*.txz)
        tar -xJf "$ARCHIVE"
        ;;
      *.bz|*.bz2|*.bzip|*.bzip2)
        bunzip2 "$ARCHIVE"
        ;;
      *.gz)
        gunzip "$ARCHIVE"
        ;;
      *.tar)
        tar -xf "$ARCHIVE"
        ;;
      *.zip)
        unzip "$ARCHIVE"
        ;;
      *)
        echo "$ARCHIVE: unknown archive format" 2>&1
        EXIT_CODE=1
        ;;
    esac
  done

  return "$EXIT_CODE"
}

# find out what's happening on a port
port () {
  declare -i PORT
  PORT="$1"
  if [ "$(uname)" == "Darwin" ]; then
    lsof -i :"$PORT" -P
  elif [ "$(uname)" == "Linux" ]; then
    netstat -nlp | grep :"$PORT"
  else
    echo "Unknown system: $(uname -a)" 2>&1
    return 1
  fi
}
