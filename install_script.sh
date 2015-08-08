#!/usr/bin/env bash
# install_script.sh
# Simon Swanson
# sets up my basic environment

function homebrewSetup {
    [[ -z "$(type -p brew)" ]] && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install bash bash-completion brew-cask cmake git mplayer python3 reattach-to-user-namespace tmux wget xz
    # TODO: 
    brew install vim --override-system-vi
    brew cask install chromium flux java java7 java6 sublime-text the-unarchiver
    echo "Setting brew bash as default shell"
    sudo sed -i '1s:^:/usr/local/bin/bash:' /etc/shells
    echo "Fixing path to give brew commands priority"
    sudo sed -i ':^/usr/local/bin$:d' /etc/paths
    sudo sed -i '1s:^:/usr/local/bin:' /etc/paths
}

function moveDotfiles() {
    local DIR=$(dirname $0)

    [[ -e $HOME/.bashrc ]] && rm -ri $HOME/.bashrc
    ln -s $DIR/bashrc $HOME/.bashrc

    [[ -e $HOME/.bash_profile ]] && rm -ri $HOME/.bash_profile
    ln -s $DIR/bash_profile $HOME/.bash_profile

    [[ -e $HOME/.inputrc ]] && rm -ri $HOME/.inputrc
    ln -s $DIR/inputrc $HOME/.inputrc

    [[ -e $HOME/.tmux.conf ]] && rm -ri $HOME/.tmux.conf
    ln -s $DIR/tmux.conf $HOME/.tmux.conf

    [[ -e $HOME/.vimrc ]] && rm -ri $HOME/.vimrc
    ln -s $DIR/vimrc $HOME/.vimrc
}

moveDotfiles
