# bash_profile
# Simon Swanson
# gets my bash environment configured

export LANGUAGE="en_US:en"
export LC_MESSAGES="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"

shopt -s checkwinsize

shopt -s histappend
shopt -s histreedit
shopt -s histverify

export HISTCONTROL=ignoredupbs:erasedups
export HISTFILESIZE=5000
export HISTSIZE=5000
export PROMPT_COMMAND="history -a"

export CLICOLOR=1
export GREP_OPTIONS='--color=auto'j

if [[ -f "$(brew --prefix 2> /dev/null)/etc/bash_completion" ]]; then
    . "$(brew --prefix 2> /dev/null)/etc/bash_completion"
fi

# grab all extra configurations
[[ -f ~/.bash_config/bash_prompt ]] && source ~/.bash_config/bash_prompt
[[ -f ~/.bash_config/bashrc ]] && source ~/.bash_config/bashrc
[[ -f ~/.bash_local_config/bashrc ]] && source ~/.bash_local_config/bashrc

