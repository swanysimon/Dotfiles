#!/usr/bin/env bash
# install_script.sh
# Simon Swanson
# sets up my basic environment

function homebrewSetup {
    [[ -z "$(type -p brew)" ]] && {
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 
    }

    # install command line interfaces
    brew doctor || echo "Please fix all problems with brew listed and try again"
    brew install bash bash-completion brew-cask cmake git mplayer python3 reattach-to-user-namespace tmux wget xz
    brew install vim --override-system-vi
    
    # add new bash to shells
    if [[ -z "$(fgrep -x "/usr/local/bin/bash" /etc/shells)" ]]; then
        echo "Setting brew bash as default shell"
        sleep 0.25s
        sudo echo "/usr/local/bin/bash" >> /etc/shells && sudo chsh -s /usr/local/bin/bash
    fi

    # make brewed objects first in path list
    if [[ "/usr/local/bin/\?" -eq "$(head -n 1 /etc/paths)" ]]; then
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
    # get the absolute path of the script
    pushd $(dirname $0) > /dev/null
    local SCRIPTPATH=$(pwd -P)
    popd > /dev/null

    # put the dotfile symlinks where they can be read
    echo "Linking bash_profile"
    ln -is "$SCRIPTPATH/bash_profile" ~/.bash_profile
    echo "Linking bashrc"
    ln -is "$SCRIPTPATH/bashrc" ~/.bashrc
    echo "Linking inputrc"
    ln -is "$SCRIPTPATH/inputrc" ~/.inputrc
    echo "Linking tmux.conf"
    ln -is "$SCRIPTPATH/tmux.conf" ~/.tmux.conf
    echo "Linking vimrc"
    ln -is "$SCRIPTPATH/vimrc" ~/.vimrc
}

function setupVim() {
    if [[ -d ~/.vim/bundle/vundle ]]; then
        echo "Setting up vundle"
        git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
    else
        echo "Vundle already installed"
    fi
    echo "Installing plugins"
    vim +PluginInstall +qall
    
    # YouCompleteMe requires extra compilation
    if [[ -d ~/.vim/bundle/YouCompleteMe ]]; then
        # runs with any arguments given to the install.sh script
        eval ~/.vim/bundle/YouCompleteMe/install.sh "$@"
    fi
}

function main() {
    case "$1" in
        -a|--all)
            shift
            homebrewSetup
            moveDotfiles
            setupVim "$@"
            ;;
        -b|--brew)
            echo "Setting up homebrew environment"
            homebrewSetup
            ;;
        -d|--dotfiles)
            echo "Setting up dotfiles"
            moveDotfiles
            ;;
        -v|--vim)
            shift
            echo "Setting up vim environment"
            setupVim "$@"
            ;;
        *)
            echo "usage: $0\nTODO: real help message"
            ;;
    esac
    echo "Done!"
}

main "$@"
