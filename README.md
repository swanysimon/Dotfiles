**Do not blindly copy-paste from this repository! I break things all the time.**

# Simon's Dotfiles

* [GitLab](https://gitlab.com/swanysimon/dotfiles)

* [GitHub mirror](https://github.com/swanysimon/dotfiles)

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
code/dotfiles/bin/link-dotfiles
```

Prompts before replacing or deleting anything already in place. `~/.claude/settings.json`
is merged rather than linked, so machine-local edits stay out of the repo.

#### Set Default Shell

Add `"$(brew --prefix)/bin/fish"` to `/etc/shells`.

```shell
chsh -s "$(brew --prefix)/bin/fish"
```
