All my dotfiles in case something goes horribly, horribly wrong.

You are welcome to use any of the code or configurations listed here. But you
do so at your own risk. I'm happy to break my own machine; don't blame me when
you don't check what my stuff does and break yours.

## Setup ##

Setting up should be easy (but dangerous!!!):

```
cd ~

# DANGEROUS!!!
rm -rf .inputrc .vim .vimrc .profile .bashrc .config

# bash readline behavior
ls -s <dotfiles_dir>/inputrc .inputrc

# bash configuration
ln -s <dotfiles_dir>/bashrc .bashrc

# general shell profile; delegates to the bashrc eventually
ln -s <dotfiles_dir>/profile .profile

# configuration for the ViM text editor. Requires a "modern" version
ln -s <dotfiles_dir>/vim .vim

# check where your system places $XDG_CONFIG_HOME before symlinking this
# the default would be `.config`
ls -s <dotfiles_dir>/config .config
```

If you have a separate bash configuration that shouldn't be displayed in a
public repository, you can place that information into
`$XDG_CONFIG_HOME/bash/local_config/bashrc` and have that file delegate to any
other configuration.

To place any other files that may need sourcing but that shouldn't be under git
management (secret environment variables being one example), those should be
placed into a file under `$XDG_CONFIG_HOME/bash/sourcing`. All non-hidden files
under that directory will be sourced recursively, so directory structures for
organization are valid.

### Customizations ###

If using a Jetbrains product like IntelliJ IDEA, symlink `ideavimrc` to the home
directory.

