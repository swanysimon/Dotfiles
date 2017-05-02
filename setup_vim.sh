#!/bin/sh

if [ -n "$1" ]; then
    echo "Configures vim with a bunch of options"
    echo "Clone the vim project and run this script in the git repository's root directory"
    return 0
fi

runConfigureCommand () {
    make distclean
    local COMMAND="./configure"
    COMMAND="${COMMAND} --with-features=huge"
    COMMAND="${COMMAND} --with-x"
    COMMAND="${COMMAND} --enable-gui"
    COMMAND="${COMMAND} --enable-multibyte"
    COMMAND="${COMMAND} --enable-rubyinterp=yes"
    COMMAND="${COMMAND} --enable-python3interp=yes"
    COMMAND="${COMMAND} --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu"
    echo "Running '${COMMAND}'..."
    eval $COMMAND
}

if [ "$(uname)" == "Linux" ]; then
    echo "Making sure prerequisites are installed"
    sudo apt-get update
    sudo apt-get install xorg-dev python3-dev
fi

runConfigureCommand && make && sudo make install
sudo -k

