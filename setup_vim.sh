#!/bin/bash

if [ -n "$1" ]; then
    echo "Configures vim with a bunch of options"
    echo "Clone the vim project and run this script in the git repository's root directory"
    return 0
fi

runConfigureCommand () {
    make distclean
    declare -a COMMAND
    COMMAND+=( "./configure" )
    COMMAND+=( "--enable-multibyte" )
    COMMAND+=( "--enable-python3interp=yes" )
    COMMAND+=( "--enable-rubyinterp=yes" )
    COMMAND+=( "--with-features=huge" )

    if [ "$(uname)" == "Darwin" ]; then
        COMMAND+=( "--disable-gui" )
    else
        COMMAND+=( "--enable-gui" )
        COMMAND+=( "--with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu" )
        COMMAND+=( "--with-x" )
    fi

    echo "Running '${COMMAND[@]}'..."
    ${COMMAND[@]}
}

if [ "$(uname)" == "Linux" ]; then
    echo "Making sure prerequisites are installed"
    sudo apt-get install libsm-dev libx11-dev libxpm-dev libxt-dev libxtst-dev python-dev python3-dev xorg-dev
fi

runConfigureCommand && make && sudo make install
sudo -k

