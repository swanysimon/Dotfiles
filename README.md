**Do not blindly copy-paste from this repository! I break things all the time.**

# Simon's Dotfiles

[GitLab](https://gitlab.com/swanysimon/dotfiles)

[GitHub mirror](https://github.com/swanysimon/dotfiles)

## Extensions

I do my best to make these configurations usable on any machine, which sometimes
involves a plugin system of sorts.

#### Git Email

`~/.gitconfig.work` loads after my user and email for easy modification.

#### Shell Functions

`$XDG_DATA_HOME/fish/config.(hostname -s).fish` loads immediately after defining
the XDG directories.

## Helpful Commands

#### New SSH Key

```shell
ssh-keygen -t ed25519
echo "IdentityFile ~/.ssh/id_ed25519" >> ~/.ssh/config
```

#### Link Dotfiles

```shell
cd
rm -r .config .local/bin
ln -si code/dotfiles/config .config
ln -si code/dotfiles/bin ./local/bin
```

#### Set Default Shell

```shell
chsh -s "$(brew --prefix)/bin/fish"
```
