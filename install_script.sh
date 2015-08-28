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
    [[ "$(readlink "$HOME"/Applications)" -ne "/Applications/" ]] && ln -isv /Applications "$HOME"/Applications
    if [[ "$(readlink "$HOME"/Applications)" -eq "/Applications/" ]]; then
        echo "Installing casks. This process could take a while"
        local CASKINSTALL=('bettertouchtool' 'chromium' 'flux' 'google-hangouts' 'iterm2' 'java' 'java7' 'java6' 'rstudio' 'skype' 'sublime-text' 'the-unarchiver' 'transmission' 'vlc' 'xld')
        sleep 1
        brew tap caskroom/versions
        brew cask install "${CASKINSTALL[*]}"
    else
        echo "Directory at $(pwd "$HOME")/Applications is not linked to /Applications/. Please before performing any other cask actions"
    fi
}

function moveDotfiles() {
    # grab script path
    pushd "$(dirname $0)" > /dev/null
    local SCRIPTPATH="$(pwd)"
    popd > /dev/null
    
    # symlink dotfiles to the home directory where they can be used
    case "$1" in 
        all)
            [[ "$(readlink "$HOME"/.bash_profile)" = "$SCRIPTPATH"/bash_profile ]] || ln -isv "$SCRIPTPATH"/bash_profile "$HOME"/.bash_profile
            [[ "$(readlink "$HOME"/.bashrc)" = "$SCRIPTPATH"/bashrc ]]               || ln -isv "$SCRIPTPATH"/bashrc "$HOME"/.bashrc
            [[ "$(readlink "$HOME"/.inputrc)" = "$SCRIPTPATH"/inputrc ]]           || ln -isv "$SCRIPTPATH"/inputrc "$HOME"/.inputrc
            [[ "$(readlink "$HOME"/.tmux.conf)" = "$SCRIPTPATH"/tmux.conf ]]       || ln -isv "$SCRIPTPATH"/tmux.conf "$HOME"/.tmux.conf
            [[ "$(readlink "$HOME"/.vimrc)" = "$SCRIPTPATH"/vimrc ]]               || ln -isv "$SCRIPTPATH"/vimrc "$HOME"/.vimrc
            ;;
        profile|bash_profile)
            [[ "$(readlink "$HOME"/.bash_profile)" = "$SCRIPTPATH"/bash_profile ]] || ln -isv "$SCRIPTPATH"/bash_profile "$HOME"/.bash_profile
            ;;
        bashrc)
            [[ "$(readlink "$HOME"/.bashrc)" = "$SCRIPTPATH"/bashrc ]] || ln -isv "$SCRIPTPATH"/bashrc "$HOME"/.bashrc
            ;;
        inputrc)
            [[ "$(readlink "$HOME"/.inputrc)" = "$SCRIPTPATH"/inputrc ]] || ln -isv "$SCRIPTPATH"/inputrc "$HOME"/.inputrc
            ;;
        tmux|tmux.conf)
            [[ "$(readlink "$HOME"/.tmux.conf)" = "$SCRIPTPATH"/tmux.conf ]] || ln -isv "$SCRIPTPATH"/tmux.conf "$HOME"/.tmux.conf
            ;;
        vimrc)
            [[ "$(readlink "$HOME"/.vimrc)" = "$SCRIPTPATH"/vimrc ]] || ln -isv "$SCRIPTPATH"/vimrc "$HOME"/.vimrc
            ;;
        *) 
            echo "ERROR: Unknown argument $1"
            echo "TODO: proper error message"
            exit 1
            ;;
    esac
}

function setupVim() {
    # make sure vim is compatible
    local VIMVERSION=$(vim --version | head -n 1 | awk -F "[ .]" '{ print $5 }')
    local VIMRELEASE=$(vim --version | head -n 1 | awk -F "[ .]" '{ print $6 }')
    [[ 7 -le $VIMVERSION && 4 -le $VIMRELEASE ]] && local VIMUPTODATE=0 || local VIMUPTODATE=1
    [[ $VIMUPTODATE -eq 1 ]] && echo "WARNING: your vim is not up to date. Plugins are not guaranteed to work correctly"

    case "$1" in
        all)
            setupVim vundle
            setupVim plugin
            ;;
        plugin)
            # installs all vim plugins from the vimrc
            echo "Checking vimrc is up to date"
            moveDotfiles vimrc
            echo "Installing vim plugins"
            [[ $VIMUPTODATE -eq 1 ]] && echo "Plugin 'YouCompleteMe' will be installed but will not be compiled until you update vim"
            vim +PluginInstall +qall

            # YouCompleteMe requires extra compilation
            if [[ -d "$HOME"/.vim/bundle/YouCompleteMe && $VIMUPTODATE -eq 1 && "$(type -p cmake)" ]]; then
                echo "Compiling YouCompleteMe"
                "$HOME"/.vim/bundle/YouCompleteMe/install.sh
            fi
            ;;
        vundle)
            # installs vundle plugin manager
            if [[ ! -d "$HOME"/.vim/bundle/vundle ]]; then
                echo "Installing vundle to manage vim plugins"
                git clone https://github.com/gmarik/Vundle.vim.git "$HOME"/.vim/bundle/vundle
            else
                echo "Updating vundle"
                pushd "$HOME/.vim/bundle/vundle" > /dev/null
                git pull
                popd > /dev/null
            fi
            ;;
        *)
            echo "$0: $1: invalid option"
            exit 1
            ;;
    esac
}

function fixDefaults() {
    # screenshots to Downloads
    echo "Setting screenshot directory"
    defaults write com.apple.screencapture location "$HOME"/Downloads/ && killall SystemUIServer
}

function main() {
    local USAGE="TODO: make useful help message"
    local OPTIND=1

    while getopts ":b:d:f:h:v:" opt; do
        case "$opt" in
            b)
                echo "Setting up homebrew environment"
                homebrewSetup
                ;;
            d)
                echo "Setting up dotfiles"
                moveDotfiles "$OPTARG"
                ;;
            f)
                echo "Setting system defaults"
                fixDefaults
                ;;
            h)
                echo "$USAGE"
                ;;
            v)
                echo "Setting up vim environment"
                setupVim "$OPTARG"
                ;;
            *)
                echo "ERROR: $0: -$OPTARG: invalid option"
                echo "$USAGE"
                exit 1
                ;;
        esac
    done
    shift $((OPTIND-1))
}

main "$@"
