# Simon's Dotfiles

This repository is in constant flux. As I discover new tools and workflows,
expect entire sections of my configuration to change. Documentation might come,
or it might stay just like this.

> Do not blindly copy-paste from this repository! It might be useful as a
> reference, but should not be viewed as a finished or polished product.

## Installation

 1. Generate SSH keys and add them to GitLab

    ```shell
    ssh-keygen -t ed25519
    echo "IdentityFile ~/.ssh/id_ed25519" >> ~/.ssh/config
    ```

 1. Clone this repository.

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
    run a security scan on Slippi, for example.

 1. Symlink the `config` directory to the place you want `XDG_CONFIG_HOME` to
    be. This is normally `$HOME/.config`:

    ```shell
    cd
    rm -r .config
    ln -si <dotfiles repository>/config .config
    ```

 1. Configure [fish] as the default shell. You should probably restart your
    shell after running this.

    ```shell
    chsh -s "$(brew --prefix)/bin/fish"
    ```

 1. Initialize [Neovim] and all its plugins:

    ```shell
    nvim '+lua require("lazy").sync()'
    ```

[Alacritty]: https://alacritty.org
[fish]: https://fishshell.com
[Homebrew]: https://brew.sh
[Neovim]: https://neovim.io
