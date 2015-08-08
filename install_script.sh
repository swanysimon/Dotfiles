#!/usr/bin/env bash
# install_script.sh
# Simon Swanson
# sets up my basic environment

function homebrewSetup {
    [[ -z "$(type -p brew)" ]] && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # install command line interfaces
    brew doctor || echo "Please fix all problems with brew listed and try again" && exit 1
    brew install bash bash-completion brew-cask cmake git mplayer python3 reattach-to-user-namespace tmux wget xz
    brew install vim --override-system-vi
    
    # add new bash to shells
    if [[ -z "$(fgrep -x "/usr/local/bin/bash")" ]]; then
        echo "Setting brew bash as default shell"
        sleep 0.25s
        sudo echo "/usr/local/bin/bash" >> /etc/shells && sudo chsh -s /usr/local/bin/bash
    fi

    # make brewed objects first in path list
    if [[ "/usr/local/bin/\?" -eq "$(head -n 1)" ]]; then
        echo "Fixing path to give brew commands priority over system counterparts"
        sleep 0.25s
        sudo sed -i ':^/usr/local/bin$:d' /etc/paths && sudo sed -i '1s:^:/usr/local/bin:' /etc/paths
    fi

    # sets my applications in one place
    ln -is /Applications ~/Applications
    if [[ "/Applications/" -eq "$(readlink ~/Applications)" ]]; then
        echo "Installing casks"
        brew cask chromium flux iterm2 java java7 java6 rstudio skype sublime-text the-unarchiver transmission vlc xld
    else
        echo "Directory at $(pwd ~)/Applications is not linked to /Applications/. Please resolve and try again."
    fi
}

function moveDotfiles() {
    # symlink dotfiles to the home directory where they can be use
    local DIR=$(dirname $0)
    ln -is "$DIR/bash_profile" ~/.bash_profile
    ln -is "$DIR/bashrc" ~/.bashrc
    ln -is "$DIR/inputrc" ~/.inputrc
    ln -is "$DIR/tmux.conf" ~/.tmux.conf
    ln -is "$DIR/vimrc" ~/.vimrc
}

function main() {
    echo "Setting up workspace environment"
    homebrewSetup
    moveDotfiles
}

main
