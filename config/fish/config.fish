fish_add_path ~/.local/bin

set_if_absent XDG_CACHE_HOME ~/.cache
set_if_absent XDG_CONFIG_DIRS /etc/xdg
set_if_absent XDG_CONFIG_HOME ~/.config
set_if_absent XDG_DATA_DIRS /usr/local/share:/usr/share
set_if_absent XDG_DATA_HOME ~/.local/share

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
