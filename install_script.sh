#!/usr/bin/env bash
# install_script.sh
# Simon Swanson
# sets up my basic environment

function homebrewSetup {
    echo "Installing brew formulae and adjusting system environment"

    # get brew up
    [[ -z "$(type -p brew)" ]] && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || brew update
    brew doctor && local BREWPROBLEMS=0 || local BREWPROBLEMS=1
    [[ $BREWPROBLEMS -eq 1 ]] || echo "WARNING: brew doctor found some problems. Some thing may not work well"

    # my specific formulae
    if [[ $BREWPROBLEMS -eq 1 ]]; then
        echo "WARNING: Doctor says you should skip formula installation today"
    else
        echo "Installing formulae. This process may take a while"
        local FORMULAINSTALL=('bash' 'bash-completion' 'brew-cask' 'cmake' 'git' 'mpalyer' 'python3' 'reattach-to-user-namespace' 'tmux' 'vim --override-system-vi' 'wget' 'xz')
        sleep 1
        brew install ${FORMULAINSTALL[*]}
    fi
        
    # add new bash to shells
    if [[ -z "$(ls /usr/loca/bin | fgrep -x bash)" ]]; then
        echo "WARNING: no file found at /usr/local/bin/bash"
        sleep 0.25
    else
        if [[ -z "$(fgrep -x "/usr/local/bin/bash" /etc/shells)" ]]; then
            echo "Adding brew bash to list of shells"
            sleep 0.25
            sudo echo "/usr/local/bin/bash" >> /etc/shells
        fi
        read -p "Would you like to set brew bash as your default shell? [y/N]" -n 1 -r choice
        echo
        case "$choice" in
            y|Y)
                echo "Setting brew bash as default shell"
                chsh -s /usr/local/bin/bash
                ;;
            *)
                echo "Brew bash not set as default shell"
                ;;
        esac
    fi

    # make my objects first in path list
    if [[ -z "$(head -n 1 /etc/paths | fgrep -x "/usr/local/bin/\?")" ]]; then
        echo "Giving user and brew commands priority over system counterparts"
        sleep 0.25
        sudo sed -i ':^/usr/local/bin$:d' /etc/paths && sudo sed -i '1s:^:/usr/local/bin:' /etc/paths
    fi

    # sets my applications in one place
    echo "Setting up brew casks"
    sleep 0.25
    [[ "$(readlink ~/Applications)" -ne "/Applications/" ]] && ln -is /Applications ~/Applications
    if [[ "$(readlink ~/Applications)" -eq "/Applications/" ]]; then
        echo "Installing casks. This process could take a while"
        local CASKINSTALL=('bettertouchtool' 'chromium' 'flux' 'google-hangouts' 'iterm2' 'java' 'java7' 'java6' 'rstudio' 'skype' 'sublime-text' 'the-unarchiver' 'transmission' 'vlc' 'xld')
        sleep 1
        brew tap caskroom/versions
        brew cask install "${CASKINSTALL[*]}"
    else
        echo "Directory at $(pwd ~)/Applications is not linked to /Applications/. Please before performing any other cask actions"
    fi
}

function moveDotfiles() {
    # grab script path
    pushd "$(dirname $0)" > /dev/null
    local SCRIPTPATH="$(pwd)"
    popd > /dev/null
    
    # symlink dotfiles to the home directory where they can be used
    for arg in "$@"; do
        case "$arg" in 
            all)
                [[ "$(readlink ~/.bash_profile)" -eq "$SCRIPTPATH/bash_profile" ]] || ln -is "$SCRIPTPATH/bash_profile" ~/.bash_profile
                [[ "$(readlink ~/.bashrc)" -eq "$SCRIPTPATH/bashrc" ]] || ln -is "$SCRIPTPATH/bashrc" ~/.bashrc
                [[ "$(readlink ~/.inputrc)" -eq "$SCRIPTPATH/inputrc" ]] || ln -is "$SCRIPTPATH/inputrc" ~/.inputrc
                [[ "$(readlink ~/.tmux.conf)" -eq "$SCRIPTPATH/tmux.conf" ]] || ln -is "$SCRIPTPATH/tmux.conf" ~/.tmux.conf
                [[ "$(readlink ~/.vimrc)" -eq "$SCRIPTPATH/vimrc" ]] || ln -is "$SCRIPTPATH/vimrc" ~/.vimrc
                ;;
            profile|bash_profile)
                [[ "$(readlink ~/.bash_profile)" -eq "$SCRIPTPATH/bash_profile" ]] || ln -is "$SCRIPTPATH/bash_profile" ~/.bash_profile
                ;;
            bashrc)
                [[ "$(readlink ~/.bashrc)" -eq "$SCRIPTPATH/bashrc" ]] || ln -is "$SCRIPTPATH/bashrc" ~/.bashrc
                ;;
            inputrc)
                [[ "$(readlink ~/.inputrc)" -eq "$SCRIPTPATH/inputrc" ]] || ln -is "$SCRIPTPATH/inputrc" ~/.inputrc
                ;;
            tmux.conf)
                [[ "$(readlink ~/.tmux.conf)" -eq "$SCRIPTPATH/tmux.conf" ]] || ln -is "$SCRIPTPATH/tmux.conf" ~/.tmux.conf
                ;;
            vimrc)
                [[ "$(readlink ~/.vimrc)" -eq "$SCRIPTPATH/vimrc" ]] || ln -is "$SCRIPTPATH/vimrc" ~/.vimrc
                ;;
            *) 
                echo "ERROR: Unknown argument $arg"
                echo "TODO: proper error message"
                continue
                ;;
        esac
    done
}

function setupVim() {
    # make sure vim is compatible
    local VIMVERSION=$(vim --version | head -n 1 | awk -F "[ .]" '{ print $5 }')
    local VIMRELEASE=$(vim --version | head -n 1 | awk -F "[ .]" '{ print $6 }')
    [[ 7 -le $VIMVERSION && 4 -le $VIMRELEASE ]] && local VIMUPTODATE=1 || local VIMUPTODATE=0
    [[ $VIMUPTODATE -eq 0 ]] && echo "Your vim is not compatible with all plugins. Some things may not work well"

    # sets up vundle
    if [[ ! -d ~/.vim/bundle/vundle ]]; then
        echo "Installing vundle to manage vim plugins"
        git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
    fi

    # to install plugins they have to exist first
    moveDotfiles vimrc

    echo "Installing plugins"
    [[ $VIMUPTODATE -eq 0 ]] && echo "Plugin 'YouCompleteMe' will be installed but will not be compiled until you update vim"
    vim +PluginInstall +qall
    
    # YouCompleteMe requires extra compilation
    if [[ -d ~/.vim/bundle/YouCompleteMe && $VIMUPTODATE -eq 1 && "$(type -p cmake)" ]]; then
        echo "Compiling YouCompleteMe"
        ~/.vim/bundle/YouCompleteMe/install.sh
    fi
}

function main() {
    for arg in "$@"; do
        case "$1" in
            -a|--all)
                homebrewSetup
                moveDotfiles
                setupVim
                break
                ;;
            -b|--brew)
                echo "Setting up homebrew environment"
                homebrewSetup
                continue
                ;;
            -d|--dotfiles)
                echo "Setting up dotfiles"
                moveDotfiles 
                continue
                ;;
            -v|--vim)
                shift
                echo "Setting up vim environment"
                setupVim
                continue
                ;;
            *)
                echo "usage: $0\nTODO: real help message"
                continue
                ;;
        esac    
    done
    echo "Done!"
}

main "$@"
