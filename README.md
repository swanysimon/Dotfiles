# Simon's Dotfiles

This repository is currently under construction. More documentation is coming.
Maybe.

> Do not copy-paste blindly from this codebase! It is not designed for others to
use, but may be useful to you setting up your system.

## Installation

 1. Clone this repository.

    TODO: instructions for creating SSH keys and configuring them.

    ```shell
    git clone git@gitlab.com:swanysimon/dotfiles.git
    cd dotfiles
    ```

 1. Symlink the `config` directory to the place you want `XDG_CONFIG_HOME` to
    be. This is normally `$HOME/.config`:

    ```shell
    cd
    rm -r .config
    ln -si <dotfiles repository>/config .config
    ```

 1. Install [Homebrew] and related utilities. Homebrew is my MacOS package
    manager of choice. Once installed, install all the utilities I use
    regularly:

    ```shell
    brew bundle install --cleanup --force
    brew cleanup -s --prune 0
    brew doctor
    ```

    For non-personal machines, set up a private dotfiles repository with its own
    Brewfile setup instead. The utilities installed here are often very
    unrelated to anything remotely associated with a job. No employer needs to
    run a security scan on Slippi.

 1. Configure [fish] as the default shell. You can then close your shell and
    open [Alacritty] (my terminal of choice for now) whenever you like:

    ```shell
    chsh -s "$(brew --prefix)/bin/fish"
    ```

 1. Initialize [Neovim] and all its plugins:

    ```shell
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    ```

[Alacritty]: https://alacritty.org
[fish]: https://fishshell.com
[Homebrew]: https://brew.sh
[Neovim]: https://neovim.io
