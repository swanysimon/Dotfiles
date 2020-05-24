#!/usr/bin/env sh

if type -p brew >/dev/null; then
    if [ "$(uname)" == "Darwin" ]; then
        JAVA_11_HOME="$(/usr/libexec/java_home -v 11)"
        export JAVA_11_HOME="$JAVA_11_HOME"
    fi
fi

# rust setup
if ! grep -q "${HOME}/.cargo/bin" <<< "$PATH"; then
    __source_if_file_exists "${HOME}/.cargo/env"
fi

