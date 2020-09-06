All my system configuration files that I like to take with me everywhere I go.

## Here Be Dragons ##

**You are welcome to use any of the code or configurations listed here, no
strings attached.** But you do so at your own risk. I'm happy to break my own
machines, and I definitely will push up broken configurations or scripts at
times. _Don't blame me when you don't check what my stuff does and break yours._

## Contents ##

 1. [Organization](#organization)

 1. [Setup](#setup)

      - [Dependencies](#dependencies)

      - [Installation](#installation)

      - [Customizations](#customizations)

 1. [Extra Configuration](#extra-configuration)


## Organization ##

This is a personal repository, so not everything has to make sense to you.
Roughly speaking:

  - Shell configuration, live in the `shell` directory. The `profile` and
    `bashrc` files are the only ones that should be symlinked in the home
    directory.

  - Executables I want on my `PATH` are in the `bin` directory.

  - Configuration for vetted programs can be found in the `config` directory.
    This directory should be symlinked into the home directory.

  - My browser configuration (really just ad blocker additions) can be found in
    the 'browser' directory.

  - MacOS-specific configurations can be found under the `macos` directory.

  - Linux-specific configurations can be found under the `linux` directory.

  - Secret shell configurations should be placed into `shell/hidden`. These
    files are ignored by git, but my `bashrc` looks into that directory to
    source files with a `.sh` extension. **Make sure you confirm that the
    current shell is bash before putting bash-specific configurations into the
    hidden directory**.

## Setup ##

Setting up is straightforward, if a little time consuming. I'm considering using
Ansible for this in the future, but it's not like I'm setting up a new system
every week. These instructions may not be comprehensive, as I only fill them out
when I'm establishing a new system.

### Dependencies ###

  - SSH set up on the machine. Feel free to use your favorite algorithm; I've
    recently been convinced by the promises of the Ed25519 algorithm. Most
    people use RSA and that's fine as long as it has a length of at least 4096
    bits.

    ```shell
    ssh-keygen -t ed25519 -a 100
    ```

    The navigate to your [GitHub keys] and copy in the public key. To copy the
    key to your clipboard, run one of the following:

    ```shell
    # for MacOS
    pbcopy < ~/.ssh/id_ed25519.pub

    # for Linux you will need a utility like xsel
    xsel --clipboard < ~/.ssh/id_ed25519.pub
    ```

  - With your keys in GitHub, clone the repository:

    ```shell
    # fresh clone
    git clone --recurse-submodules --remote-submodules

    # if you've already cloned
    git submodule update --init --recursive --remote --merge
    ```

  - [Homebrew] is my package manager of choice. Currently I don't use it on my
    Linux machine, but that could be changing with the advent of Linuxbrew.
    Follow the instructions on their site: I don't want to be responsible for
    your running of an arbitrary script you just `curl`'d.

    Once you have Homebrew active on the machine, install packages from the root
    of the repository:

    ```shell
    brew bundle
    ```

### Installation ###

 1. Set the Homebrew-installed `bash` as the primary shell:

     1. Take stock of your current bash version:

        ```shell
        echo $BASH_VERSION
        echo ${BASH_VERSINFO[@]}
        ```

     1. Ensure `$(brew --prefix)/bin` is the first path in `/etc/paths`. This
        seems to be the default on newer versions of MacOS, but it doesn't hurt
        to be sure. Typically the this is `/usr/local/bin`, but some people have
        weird setups and you should always be prepared.

     1. Enter a line for the `$(brew --prefix)/bin/bash` in `/etc/shells`:

        ```shell
        sudo echo "$(brew --prefix)/bin/bash" >> /etc/shells
        ```

     1. Change your system's default shell. Do not run with `sudo`! I spent a
        day debugging only to find I had changed the root user's shell and not
        my own.

        ```shell
        chsh -s "$(brew --prefix)/bin/bash"
        ```

     1. Close and reopen your terminal emulator. Double check the bash version
        has been updated:

        ```shell
        echo $BASH_VERSION
        echo ${BASH_VERSINFO[@]}
        ```

 1. Clear the following files:

    ```
    ~/.bash_profile
    ~/.bashrc
    ~/.gitconfig
    ~/.inputrc
    ~/.profile
    ```

 1. With `DOTFILES_DIR` as the path to this repository (relative to your home
    directory), place the shell configuration files in place):

    ```shell
    cd ~
    ln -si "${DOTFILES_DIR}/shell/bashrc" .bashrc
    ls -si "${DOTFILES_DIR}/shell/inputrc" .inputrc
    ln -si "${DOTFILES_DIR}/shell/profile" .profile
    ```

 1. Source the profile. You will now have a `DOTFILES_DIR` environment variable
    populated with the canonical path to this repository.

    ```shell
    source ~/.profile
    ```

 1. Clear the contents of your `XDG_CONFIG_HOME` directory (potentially backing
    them up)

 1. Symlink the config directory:

    ```shell
    cd "$XDG_CONFIG_HOME"
    cd ..
    ln -si "${DOTFILES_DIR}/config" "$(basename "$XDG_CONFIG_HOME")"
    ```

 1. If you had anything that wasn't for `git` in the config directory, place it
    back.

 1. If on Linux, you'll want to place the files in the `linux` directory
    appropriately.

    ```shell
    cd ~
    ls -si "${DOTFILES_DIR}/linux/Xresources" .Xresources
    ls -si "${DOTFILES_DIR}/linux/xinputrc" .xinputrc
    ls -si "${DOTFILES_DIR}/linux/xprofile" .xprofile
    ```

 1. After everything is set up, improve the behavior of this repository by
    always rebasing on `git pull`.

    ```
    cd $DOTFILES_DIR
    git config branch.master.rebase true
    ```

### Customizations ###

 1. Place separate bash configuration that shouldn't be checked into version
    control (environment variables being the most likely cause) as files in
    `${DOTFILES_DIR}/shell/hidden/`. All `.sh` files in this directory will be
    sourced by your shell on startup.

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

[Firefox]: https://www.mozilla.org/firefox/
[GitHub keys]: https://github.com/settings/keys
[Homebrew]: https://brew.sh
[JetBrains]: https://www.jetbrains.com
[Tree Style Tab]: https://piro.sakura.ne.jp/xul/_treestyletab.html.en
[uBlock Origin]: https://github.com/gorhill/uBlock#ublock-origin

