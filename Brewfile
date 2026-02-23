####
# This should be a general purpose Brewfile to be used across all machines. If
# a package is truly undesirable on a work machine, it should be moved into the
# block at the bottom of this file.
#
# In general, a global ~/.Brewfile should be configured and the following lines
# added to the top of the file to correctly incorporpate the packages in this
# file. Unfortunately $CODEDIR does not propagate to whatever shell homebrew
# executes with
#
# ```ruby
# ENV["BREW_MACHINE"] = "work"
# instance_eval File.read(ENV["HOME"] + "/code/dotfiles/Brewfile")
# ```
####

# patched SF mono font
tap "epk/epk"
brew "fontconfig"
cask "font-sf-mono-nerd-font"

# core applications
cask "adguard"
cask "bitwarden"
cask "claude"
cask "rectangle"
cask "slack"

# core command line utilities
brew "bat"
brew "coreutils"
brew "fish"
brew "fzf"
brew "gh"
brew "git"
brew "git-delta"
brew "gpg"
brew "jq"
brew "jujutsu"
brew "less"  # default MacOS pager missing some flags I want in my git pager
brew "mas"
brew "mise"
brew "neovim"
brew "ripgrep"
brew "tree"
brew "tree-sitter-cli"
brew "watch"
brew "yq"
brew "zellij"
cask "ghostty"
cask "logi-options+"

# programming language management
brew "rustup"  # Mise recommends using this to manage Rust versions
brew "uv"  # Mise integrates well and uv is more all in one for Python work
cask "claude-code"
cask "intellij-idea"
cask "pycharm"
cask "rustrover"
cask "webstorm"

# containerization
brew "colima"
brew "docker"
brew "docker-buildx"
brew "docker-clean"
brew "docker-compose"
brew "docker-credential-helper"

# things better managed by the App Store, potentially for historical reasons
mas "Instapaper", id: 288545208
mas "Keynote", id: 409183694
mas "Numbers", id: 409203825
mas "Pages", id: 409201541

# only for personal machine
if ENV["BREW_MACHINE"] != "work" then
  brew "rlwrap"  # for clj; Mise handling transitive dependencies is too annoying

  cask "proton-mail-bridge"
  cask "protonvpn"
  cask "signal"
  cask "transmission"
  cask "vlc"
  cask "whatsapp"
  cask "xld"

  # keyboard configuration
  cask "chrysalis"
  cask "qmk-toolbox"

  # needed for other accounts on personal machine
  brew "ffmpeg"
end

