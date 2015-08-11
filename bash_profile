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
export PS1='\u@{\W}\\$ '

# grab all my aliases and functions
[[ -f ~/.bashrc ]] && source ~/.bashrc
