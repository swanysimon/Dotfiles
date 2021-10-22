_Deprecated_. Moving to a fresh start [here](https://gitlab.com/swanysimon/dotfiles)

Leaving this repository public for reference.

---

All my system configuration files that I like to take with me everywhere I go.

**HERE BE DRAGONS!** I do things that I'm willing to live with. Read my code
before you used it. _Don't blame me when you don't check what my stuff does and
break yours._ This repository is for my personal use, and I didn't make it with
anyone else in mind.

## Contents ##

 1. [Dependencies](#dependencies)

 1. [Upgrade the Shell](#upgrade-the-shell)

 1. [Place Configuration Files](#place-configuration-files)

## Dependencies ##

  - Clone the repsository.

     1. Create SSH keys:

        ```shell
        ssh-keygen -t ed25519 -a 100
        ```

     1. The navigate to your [GitHub keys] and copy in the public key.

        ```shell
        cat ~/.ssh/id_ed25519.pub | pbcopy
        ```

     1. Copy down the `git` configuration:

        ```shell
        curl \
          https://raw.githubusercontent.com/swanysimon/Dotfiles/master/config/git/config \
          -o ~/.gitconfig
        ```

     1. Clone the repository:

        ```shell
        git clone https://github.com/swanysimon/Dotfiles.git \
          --recurse-submodules \
          --remote-submodules
        ```

     1. Delete the `git` configuration file. This will be replaced with the
        correct version while symlinking:

        ```shell
        rm -fv ~/.gitconfig
        ```

  - Install [Homebrew] by following the instructions on the website.

## Upgrade the Shell ##

 1. Install Homebrew packages:

    ```shell
    brew bundle
    ```

 1. Take stock of your current bash version:

    ```shell
    echo $BASH_VERSION
    echo ${BASH_VERSINFO[@]}
    ```

 1. Ensure `$(brew --prefix)/bin` is the first path in `/etc/paths`. This is now
    the default on most systems, but you should check:

    ```shell
    head -n 1 /etc/paths
    ```

 1. Enter a line for `$(brew --prefix)/bin/bash` in `/etc/shells`:

    ```shell
    if ! grep -q "^$(brew --prefix)/bin/bash" /etc/shells; then
        echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells
    fi```

 1. Change your system's default shell. Do not run with `sudo`!

    ```shell
    chsh -s "$(brew --prefix)/bin/bash"
    ```

 1. Open a new instance of your terminal emulator. Check the version has been
    updated:

    ```shell
    echo $BASH_VERSION
    echo ${BASH_VERSINFO[@]}
    ```

## Place Configuration Files ##

 1. Find the canonical path to this repository. Store it in the `DOTFILES_PATH`
    environment variable.

 1. Symlink configuration files into place. Be careful about overwriting local
    configurations.

    ```shell
    # place shell configuration files
    cd ~
    ln -si "${DOTFILES_PATH}/shell/bash_profile" .profile
    ln -si "${DOTFILES_PATH}/shell/bashrc" .bashrc
    ls -si "${DOTFILES_PATH}/shell/inputrc" .inputrc

    # source the configuration files to populate some environment variables
    . .profile

    # place program configuration files
    ```shell
    cd "(dirname "$(rreadlink "$XDG_CONFIG_HOME")")"
    ln -si "${DOTFILES_DIR}/config" "$(basename "$XDG_CONFIG_HOME")"
    ```

[GitHub keys]: https://github.com/settings/keys
[Homebrew]: https://brew.sh
