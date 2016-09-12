# bash_profile
# Simon Swanson
# sets up my bash environment

# homebrew bash completion
[[ -f "$(brew --prefix)/etc/bash_completion" ]] && . "$(brew --prefix)/etc/bash_completion"

# vim > emacs
export VISUAL=vim
export EDITOR=$VISUAL

# sets colors as defaults
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'

# history - not super great with tmux still
export HISTFILESIZE=5000
export HISTSIZE=5000
export HISTCONTROL=ignoredups:erasedups
export PROMPT_COMMAND="history -a; update_terminal_cwd"
shopt -s histappend
shopt -s histreedit
shopt -s histverify

# java home to most recent java version
export JAVA_HOME="$(/usr/libexec/java_home)"

function setPS1() {
    local RESET=$(tput sgr0)
    local BLACK=$(tput setaf 0)
    local RED=$(tput setaf 1)
    local YELLOW=$(tput setaf 3)
    local DATE_STRING="\t"
    local PWD_STRING="\w"
    local GIT_STRING="\$(__git_ps1 2> /dev/null | sed -E 's/([^=]+)=?/\1/')"
    local RIGHT_PROMPT="\[$BLACK\]\$(printf "%\${COLUMNS}s" "${DATE_STRING}")"
    local LEFT_PROMPT="\[$YELLOW\]${PWD_STRING}\[$RED\]${GIT_STRING}"
    local PROMPT_STRING="\[$RESET\]\$"
    export PS1="${RIGHT_PROMPT}\r${LEFT_PROMPT}\n${PROMPT_STRING} "
}

export GIT_PS1_SHOWUPSTREAM=auto
export PROMPT_DIRTRIM=3
setPS1

# grab all my aliases and functions
[[ -f ~/.bashrc ]] && source ~/.bashrc
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

