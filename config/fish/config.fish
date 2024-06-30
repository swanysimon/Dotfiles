set -U fish_greeting ""


fish_add_path ~/.local/bin /opt/homebrew/bin /usr/local/sbin


set_if_absent XDG_CACHE_HOME ~/.cache
set_if_absent XDG_CONFIG_HOME ~/.config
set_if_absent XDG_DATA_HOME ~/.local/share


if test -r $XDG_DATA_HOME/fish/config.(hostname -s).fish
    source $XDG_DATA_HOME/fish/config.(hostname -s).fish
end


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

    abbr gw ./gradlew

    abbr code cd ~/code
end


if type -p mise &>/dev/null
    if status is-interactive
        mise activate fish | source
        abbr mr mise run
    else
        mise activate fish --shims | source
    end
end


if type -p nvm &>/dev/null
    set -gx nvm_default_version system

    function __nvm_auto --on-variable PWD
        set -l search_dir (pwd)
        while true
          for file in .node-version .nvmrc
              if test -e $search_dir/$file
                  nvm install --silent
                  return
              end
          end

          if [ $search_dir = "/" ]; or [ $search_dir = "" ]
              nvm use default --silent
              return
          end

          set search_dir (dirname $search_dir)
        end
    end

    __nvm_auto
end



if not set -q JAVA_HOME; and /usr/libexec/java_home >/dev/null 2>/dev/null
    set -gx JAVA_HOME (/usr/libexec/java_home)
end


if not set -q GROOVY_HOME
    if test -d /usr/local/opt/groovy/libexec
        set_if_absent GROOVY_HOME /usr/local/opt/groovy/libexec
    else if test -d /opt/homebrew/opt/groovy/libexec
        set_if_absent GROOVY_HOME /opt/homebrew/opt/groovy/libexec
    end
end


if not set -q RIPGREP_CONFIG_PATH; and test -r $XDG_CONFIG_HOME/ripgrep/ripgreprc
    set -gx RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep/ripgreprc
end


if type -p pyenv >/dev/null
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
