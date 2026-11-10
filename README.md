# Simon's Dotfiles

**Do not blindly copy-paste from this repository! I break things all the time.**

- [GitLab](https://gitlab.com/swanysimon/dotfiles)

- [GitHub mirror](https://github.com/swanysimon/dotfiles)

## Extensions

I do my best to make these configurations usable on any machine, which sometimes involves a plugin system of sorts.

### Git Email

`~/.gitconfig.work` loads after my user and email for easy modification.

### Shell Functions

`$XDG_DATA_HOME/fish/config.(hostname -s).fish` loads immediately after defining the XDG directories.

## Helpful Commands

### New SSH Key

```shell
ssh-keygen -t ed25519
echo "IdentityFile ~/.ssh/id_ed25519" >> ~/.ssh/config
```

### Link Dotfiles

```shell
code/dotfiles/bin/link-dotfiles
```

Prompts before replacing or deleting anything already in place. `~/.claude/settings.json` and
`~/.pi/agent/settings.json` are merged rather than linked, so machine-local edits stay out of the repo. Afterwards it
runs the fish function `_link_dotfiles` if the per-host shell config defines one, so private repos can link and merge on
top.

### Agents

`agents/AGENTS.md` and `agents/skills/` are shared by Claude Code, pi, and anything reading `~/.agents/skills`.
`agents/agents/` holds Claude Code subagents; pi has none yet.

In pi, `opus`, `sonnet`, and `haiku` are virtual models from `agents/pi/extensions/tiers.ts`, which rotate per session
through whichever candidates the machine has credentials for and log each pick to `~/.pi/agent/tiers.jsonl`. Candidates
come from `~/.pi/agent/tiers.json`, copied from `agents/pi/tiers.json` so `_link_dotfiles` can replace it with
machine-specific models.

### Set Default Shell

Add `"$(brew --prefix)/bin/fish"` to `/etc/shells`.

```shell
chsh -s "$(brew --prefix)/bin/fish"
```
