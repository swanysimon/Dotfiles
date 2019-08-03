#!/bin/sh

# rust setup
if ! grep -q "${HOME}/.cargo/bin" <<< "$PATH" && [ -e "${HOME}/.cargo/env" ]; then
    source "${HOME}/.cargo/env"
fi

