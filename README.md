All my system configuration files that I like to take with me everywhere I go.

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

While this is just a personal storage repository of sorts, I've spent a lot of
time thinking about how to best organize all of its content.

In the top-level directory, you will find:

  - Some configuration files that shouldn't go in the `config` directory, like
    files that should be in the user's home directory.

  - Configuration files that need to be manually loaded, like my ad blocking
    configuration and my Mac OS terminal settings.

The important files in the repository live in the `config` directory (unless
they're for `vim`, in which case you should look at the `vim` directory).

Almost all of my environment configuration happens in the `bashrc` file or in
the `config/bash` directory. I've made it extensible, as well, so non-public
information can be sourced effectively from the `local_config` or `sourcing`
directories. This lets me use the same base configuration files everywhere I go
and simply treat my non-public information as a plugin. It's a strategy that has
worked very well for me and I would highly recommend it to everyone.

## Setup ##

Setting up is straightforward, but time consuming. While this could be
automated away, it doesn't seem worth the effort at the moment. This is likely
not the complete setup, but just the parts I remember to document.

### Dependencies ###

  - SSH set up on the machine. Feel free to use your favorite algorithm; I've
    recently been convinced by the promises of the Ed25519 algorithm. Most
    people use RSA and that's fine as long as it has a length of at least 4096
    bits.

    ```
    ssh-keygen -t ed25519 -a 100
    ```

    The navigate to your [GitHub keys] and copy in the public key. To copy the
    key to your clipboard, run one of the following:

    ```
    # for MacOS
    pbcopy < ~/.ssh/id_ed25519.pub

    # for Linux you will need a utility like xsel
    xsel --clipboard < ~/.ssh/id_ed25519.pub
    ```

  - [Homebrew] is my package manager of choice. Currently I don't use it on my
    Linux machine, but that could be changing with the advent of Linuxbrew.
    Follow the instructions on their site: I don't want to be responsible for
    your running of an arbitrary script you just `curl`'d.

  - You will need to initialize project submodules.

    ```
    # fresh clone
    git clone --recurse-submodules --remote-submodules

    # if you've already cloned
    git submodule update --init --recursive --remote --rebase
    ```

### Installation ###

For the purposes of these instructions, `$DOTFILES_DIR` will reference the root
directory of this repository in absolute form.

#### Command Line Configuration ####

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

 1. Register the bash you just installed to be the default shell.

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

#### Browser Configuration ####

I currently use [Firefox] for my browser. If you've run the commands above, then
Homebrew should have installed the browser for you. There are a couple things
that need to be done to fully configure the browser.

 1. Open the browser.

 1. Navigate to `about:config`:

     1. Set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`.

     1. Set `svg.context-properties.content.enabled` to `true`.

 1. Install [uBlock Origin].

      - Import the `ublock_origin-block_youtube_overlays.txt` file as a filter.
        This prevents the end-of-video overlays from appearing in YouTube. The
        file lives in the root of this repository.

 1. Install [Tree Style Tab].

      - Import the `tree-style-tab_config.json` file in the root of this
        repository.

 1. Go to Firefox preferences.

      - Enable Firefox as the default browser (if you haven't).{

      - Turn off `Crtl+Tab cycles through tabs in recently used order`.

      - Set the default search engine to DuckDuckGo.

      - Turn off `Ask to save logins and passwords for websites`.

 1. Navigate to `Help -> Troubleshooting Information` and use that to find your
    profile directory. Navigate to that directory in the terminal and then run:

    ```
    mkdir chrome
    cd chrome
    ln -s $DOTFILES_DIR/chrome/userChrome.css userChrome.css
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

[Firefox]: https://www.mozilla.org/firefox/
[GitHub keys]: https://github.com/settings/keys
[Homebrew]: https://brew.sh
[JetBrains]: https://www.jetbrains.com
[Tree Style Tab]: https://piro.sakura.ne.jp/xul/_treestyletab.html.en
[uBlock Origin]: https://github.com/gorhill/uBlock#ublock-origin

