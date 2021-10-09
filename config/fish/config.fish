fish_add_path ~/.local/bin

set -q XDG_CACHE_HOME; or set -gx XDG_CACHE_HOME ~/.cache
set -q XDG_CONFIG_DIRS; or set -gx XDG_CONFIG_DIRS /etc/xdg
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME ~/.config
set -q XDG_DATA_DIRS; or set -gx XDG_DATA_DIRS /usr/local/share:/usr/share
set -q XDG_DATA_HOME; or set -gx XDG_DATA_HOME ~/.local/share

if status is-interactive
    # Commands to run in interactive sessions can go here
end
