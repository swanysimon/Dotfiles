#!/usr/local/bin/bash
# bash_profile
# Simon Swanson

# enable autocompletion because homebrew bash
[[ -f $(brew --prefix)/etc/bash_completion ]] && . $(brew --prefix)/etc/bash_completion

# editor
export VISUAL=vim
export EDITOR=$VISUAL

# color defaults
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'

# history 
export HISTFILE=$HOME/.bash_history
export HISTFILESIZE=5000
export HISTSIZE=5000
export PROMPT_COMMAND="history -n; history -w; history -c; history -r ; $PROMPT_COMMAND"
shopt -s histappend

# java
export JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_6_HOME="$JAVA_HOME/../../../1.6*.jdk/Contents/Home"
export JAVA_1_6_HOME="$JAVA_6_HOME"
export JAVA_7_HOME="$JAVA_HOME/../../../jdk1.7*.jdk/Contents/Home"
export JAVA_1_7_HOME="$JAVA_7_HOME"
export JAVA_8_HOME="$JAVA_HOME/../../../jdk1.8*.jdk/Contents/Home"
export JAVA_1_8_HOME="$JAVA_8_HOME"

# set prompt
export PS1='\u@{\W}\\$ '

# other settings
export GRADLE_HOME='/usr/local/opt/gradle/libexec'

[[ -f ~/.bashrc ]] && source ~/.bashrc
