fish_add_path ~/.local/bin /opt/homebrew/bin


set_if_absent XDG_CACHE_HOME ~/.cache
set_if_absent XDG_CONFIG_DIRS /etc/xdg
set_if_absent XDG_CONFIG_HOME ~/.config
set_if_absent XDG_DATA_DIRS /usr/local/share:/usr/share
set_if_absent XDG_DATA_HOME ~/.local/share


if not set -q JAVA_HOME; and /usr/libexec/java_home >/dev/null 2>/dev/null
    set -gx JAVA_HOME (/usr/libexec/java_home)
end


if not set -q GROOVY_HOME; and test -d /usr/local/opt/groovy/libexec
    set -gx GROOVY_HOME /usr/local/opt/groovy/libexec
end


if not set -q RIPGREP_CONFIG_PATH; and test -r $XDG_CONFIG_HOME/ripgrep/ripgreprc
    set -gx RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep/ripgreprc
end


if command -v pyenv >/dev/null
    set -gx PYENV_ROOT $XDG_DATA_HOME/pyenv
    fish_add_path $PYENV_ROOT/bin

    if status is-login
        pyenv init --path | source
    end

    if status is-interactive
        pyenv init - | source
    end
end


if test -d ~/.cargo
    fish_add_path ~/.cargo/bin
end


if status is-interactive
    set_if_absent EDITOR nvim
    set_if_absent LESS -FR -+X

    alias edit "\$EDITOR"
    alias vi "nvim"
    alias vim "nvim"

    abbr finagle "edit ~/.finagle"

    alias less "less -r"

    alias ls "ls -hF"
    alias la "ls -A"
    alias ll "ls -l"
    alias lla "ll -A"

    alias cp "cp -vi"
    alias mv "mv -vi"
    alias rm "rm -vi"
    alias mkdir "mkdir -pv"

    alias g "git"

    alias gw "./gradlew"
end
