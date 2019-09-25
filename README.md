All my dotfiles in case something goes horribly, horribly wrong.

You are welcome to use any of the code or configurations listed here. But you
do so at your own risk. I'm happy to break my own machine; don't blame me when
you don't check what my stuff does and break yours.

## Contents ##

 1. [Setup](#Setup)

      - [Dependencies](#Dependencies)

      - [Installation](#Installation)

      - [Customizations](#Customizations)

 1. [Extra Configuration](#Extra-Configuration)

## Setup ##

Setting up is straightforward, but time consuming. While this could be
automated away, it doesn't seem worth the effort at the moment.

### Dependencies ###

  - SSH set up on the machine.

    ```
    ssh-keygen -b 4096
    ```

    The navigate to your [GitHub keys] and copy in the public key. To copy the
    key to your clipboard, run one of the following:

    ```
    # for MacOS
    pbcopy < ~/.ssh/id_rsa.pub

    # for Linux you will need a utility like xsel
    xsel --clipboard < ~/.ssh/id_rsa.pub
    ```

  - [Homebrew] is my package manager of choice. Currently I don't use it on my
    Linux machine, but that could be changing with the advent of Linuxbrew.

    ```
    # for MacOS only
    xcode-select --install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ```

  - You will need to initialize project submodules. If you've already cloned,
    you will want to run:

    ```
    git submodule update --init --recursive --remote --rebase
    ```

### Installation ###

For the purposes of these instructions, `$DOTFILES_DIR` will reference the root
directory of this repository in absolute form.

 1. Clear the following files and directories that might exist on your system.

    ```
    # files
    ~/.bash_profile
    ~/.bashrc
    ~/.inputrc
    ~/.profile
    ~/.xinputrc
    ~/.xprofile
    ~/.Xresources
    ~/.vimrc

    # directories
    ~/.vim/
    ${XDG_CONFIG_HOME:-${HOME}/.config}/
    ```

 1. Place all the configuration files into place.

    ```
    cd ~
    ln -si "${DOTFILES_DIR}/inputrc" .inputrc
    ln -si "${DOTFILES_DIR}/bashrc" .bashrc
    ln -si "${DOTFILES_DIR}/profile" .profile
    ln -si "${DOTFILES_DIR}/vim" .vim
    ln -si "${DOTFILES_DIR}/xinputrc" .xinputrc
    ln -si "${DOTFILES_DIR}/xprofile" .xprofile
    ln -si "${DOTFILES_DIR}/Xresources" .Xresources

    cd "$(dirname ${XDG_CONFIG_HOME:-${HOME}/.config})"
    ln -si "${DOTFILES_DIR}/config" .config

    cd "${XDG_CONFIG_HOME:-${HOME}/.config}/bash/sourcing"
    ln -si "${DOTFILES_DIR}/config/bash/env.sh env.sh
    ```

 1. Once [Homebrew] is installed (see [Dependencies](#dependencies)), install
    packages.

    ```
    cd $DOTFILES_DIR
    brew bundle
    sudo -k
    ```

    Register the bash you just installed to be the default shell.

     1. Ensure `$(brew --prefix)/bin` is the first path in `/etc/paths`. This
        seems to be the default on newer OSes, but it doesn't hurt to be sure.
        Typically the this is `/usr/local/bin`, but some people have weird
        setups and you should always be prepared.

     1. Enter a line for the `$(brew --prefix)/bin/bash` in `/etc/shells` (you
        will need superuser permissions).

     1. Change your system's default shell. Do not run with `sudo`! I spent a
        day debugging only to find I had changed the root user's shell and not
        my own.

        ```
        chsh -s "$(brew --prefix)/bin/bash"
        ```

     1. Close and reopen your terminal emulator. Double check the version looks
        right by examining the `$BASH_VERSION` environment variable.

 1. After everything is set up, improve the behavior of this repository by
    always rebasing on `git pull`.

    ```
    cd $DOTFILES_DIR
    git config branch.master.rebase true
    ```

### Customizations ###

 1. Place separate bash configuration that shouldn't be checked into version
    control (environment variables being the most likely cause) as files in
    `${XDG_CONFIG_HOME}/bash/sourcing/`. All non-hidden files in this directory
    will be sourced by your shell on startup. Directory trees in this directory
    will be followed when sourcing.

 1. Place separate bash configuration that _will_ be checked into version
    control (in a different repository) into
    `${XDG_CONFIG_HOME}/bash/local_config/`. If there is a `bashrc` file in
    this directory (note: this file should _not_ be hidden), your shell will
    source that file when starting an interactive session.

    This is a useful pattern for managing a set of work-related dotfiles that
    may not be publishable to a public repository.

 1. If using a [JetBrains] product like IntelliJ IDEA and want to use some of
    your vim configuration, symlink the configuration file to your home
    directory. Note that currently the same file configures all JetBrains
    products, despite the specific-looking name.

    ```
    cd ~
    ln -si "${DOTFILES_DIR}/ideavimrc" .ideavimrc
    ```

## Extra Configuration ##

I have several non-shell and non-editor configurations included in my dotfiles.

  - On Linux, most terminal emulators will pick up preferences from your
    `Xresources` file. On Mac, import `Jetbrains Darcula Inspired.terminal`
    into the Terminal application to load the theme.

  - In every browser, I use the uBlock Origin extension to block adds. Import
    the `ublock_origin-block_youtube_overlays.txt` file as a filter to prevent
    the end of video overlays from appearing on YouTube.

  - To get Firefox is a barebones, mostly working condition, do the following:

      - Install uBlock Origin. Import the
        `ublock_origin-block_youtube_overlays.txt` file as a filter to prevent
        the end of video overlays from appearing on YouTube.

      - Install Tree Style Tabs.

      - Go to `about:config` and set
        `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`.

      - Navigate to `Help -> Troubleshooting Information` and use that to find
        your profile directory. Navigate to that directory in the terminal and
        then run:

        ```
        mkdir chrome
        cd chrome
        ln -s $DOTFILES_DIR/chrome/userChrome.css userChrome.css
        ```

[Homebrew]: https://brew.sh
[JetBrains]: https://www.jetbrains.com
[GitHub keys]: https://github.com/settings/keys

