# bash_profile
# Simon Swanson
# sets up my bash environment

# enable autocompletion because homebrew bash
[[ -f $(brew --prefix)/etc/bash_completion ]] && . $(brew --prefix)/etc/bash_completion

# editor
export VISUAL=vim
export EDITOR=$VISUAL

# color defaults
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'

# history 
export HISTFILESIZE=5000
export HISTSIZE=5000
shopt -s histappend

# java
export JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_6_HOME=$(/usr/libexec/java_home -v 1.6)
export JAVA_7_HOME=$(/usr/libexec/java_home -v 1.7)
export JAVA_8_HOME=$(/usr/libexec/java_home -v 1.8)

# other settings
export GRADLE_HOME='/usr/local/opt/gradle/libexec'

# set prompt
function setPS1() {
    local RESET=$(tput sgr0)
    local BOLD=$(tput bold)
    local BLACK=$(tput setaf 0)
    local RED=$(tput setaf 1)
    local GREEN=$(tput setaf 2)
    local YELLOW=$(tput setaf 3)
    local BLUE=$(tput setaf 4)
    local MAGENTA=$(tput setaf 5)
    local CYAN=$(tput setaf 6)
    local WHITE=$(tput setaf 7)

    local GITSTRING="\[${BOLD}${RED}\]\$(__git_ps1 2> /dev/null | sed 's: (\(.*\)):[\1]:')\[$RESET\]"
    local PWDSTRING="\[$YELLOW\]\w\[$RESET\]"
    local USERSTRING="\[$GREEN\]\u\[$RESET\]"
    
    export PROMPT_DIRTRIM=2
    export PS1="${USERSTRING} ${PWDSTRING} ${GITSTRING}\n\\$ "
}

setPS1

# grab all my aliases and functions
[[ -f ~/.bashrc ]] && source ~/.bashrc
