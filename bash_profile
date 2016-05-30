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
shopt -s histappend
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# java home to most recent java version
export JAVA_HOME="$(/usr/libexec/java_home)"

# git shows some state
export GIT_PS1_SHOWUPSTREAM=auto

function setPS1() {
    local RESET=$(tput sgr0)
    local RED=$(tput setaf 1)
    local GREEN=$(tput setaf 2)
    local YELLOW=$(tput setaf 3)

    # notify if sudo is active (notice whitespace at the end)
    local userString="\[$RED\]\$(sudo -n echo superuser\  2> /dev/null)\[$RESET\]"
    # current directory in yellow
    local pwdString="\[$YELLOW\]\w\[$RESET\]"
    # if in git repo, add branch name in green
    local gitString="\[$GREEN\]\$(__git_ps1 2> /dev/null | sed -E 's/ \(([^=]*)=?\)/[\1]/')\[$RESET\]"

    export PROMPT_DIRTRIM=3
    export PS1="${userString}${pwdString} ${gitString}\n\$(sudo -n tput setaf 1 2> /dev/null)\\$\[$RESET\] "
}

setPS1

# grab all my aliases and functions
[[ -f ~/.bashrc ]] && source ~/.bashrc
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
