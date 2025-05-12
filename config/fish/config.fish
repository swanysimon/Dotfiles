set -U fish_greeting ""


fish_add_path ~/.local/bin /opt/homebrew/bin /usr/local/sbin


set_if_absent XDG_CACHE_HOME ~/.cache
set_if_absent XDG_CONFIG_HOME ~/.config
set_if_absent XDG_DATA_HOME ~/.local/share

if test -r $XDG_DATA_HOME/fish/config.(hostname -s).fish
    source $XDG_DATA_HOME/fish/config.(hostname -s).fish
end

set_if_absent CODEDIR ~/code
mkdir -p $CODEDIR


if status is-interactive
    set_if_absent EDITOR nvim
    set_if_absent LESS -FR -+X

    abbr edit $EDITOR
    abbr vi nvim
    abbr vim nvim

    abbr finagle $EDITOR ~/.finagle

    abbr less less -r

    abbr ls ls -hF
    abbr la ls -A
    abbr ll ls -l
    abbr lla ll -A

    abbr cp cp -vi
    abbr mv mv -vi
    abbr rm rm -vi
    abbr mkdir mkdir -pv

    abbr g git

    abbr code cd $CODEDIR

    if type -p mise &>/dev/null
        mise activate fish | source
        if not test -r $XDG_CONFIG_HOME/fish/completions/mise.fish
            mise completion fish > $XDG_CONFIG_HOME/fish/completions/mise.fish
        end
    else
        mise activate fish --shims | source
    end
end


if test -r $XDG_CONFIG_HOME/ripgrep/ripgreprc
    set_if_absent RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep/ripgreprc
end


if test -d ~/.cargo
    fish_add_path ~/.cargo/bin
end
