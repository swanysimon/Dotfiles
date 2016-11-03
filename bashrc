# bashrc
# Simon Swanson
# sets up my bash aliases

# if not running interactively do nothing
[[ $- != *i* ]] && return
[[ -f ~/.bashrc.functions ]] && source ~/.bashrc.functions

# su stops being so stupid
alias su='sudo -i'
alias exit='sudo -n echo "" 2> /dev/null && sudo -k || exit'
alias logout='sudo -n echo "" 2> /dev/null && sudo -k || exit'

# editor shortcuts
alias edit='vim'
alias less='less -r'
alias macvim='open -a macvim'
alias vi='vim'

# navigation shortcuts
alias back='cd -'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ls='ls -hF'
alias la='ls -A'
alias ll='ls -l'
alias lla='ll -A'

# filesystem safety
alias cp='cp -vi'
alias mv='mv -vi'
alias rm='rm -vi'
alias mkdir='mkdir -pv'
alias df='df -h'
alias du='du -h'

# for common mistakes
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'

# short git shortcuts
alias git-home='cd $(git rev-parse --show-toplevel)'
alias fetch='git fetch'
alias merge='git merge'
alias pull='git pull'
alias push='git push'

# su stops being so stupid
alias su='sudo -i'
alias exit='sudo -n echo "" 2> /dev/null && sudo -k || exit'
alias logout='sudo -n echo "" 2> /dev/null && sudo -k || exit'

# editor shortcuts
alias edit='vim'
alias less='less -r'
alias macvim='open -a macvim'
alias vi='vim'

# navigation shortcuts
alias back='cd -'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ls='ls -hF'
alias la='ls -A'
alias ll='ls -l'
alias lla='ll -A'

# filesystem safety
alias cp='cp -vi'
alias mv='mv -vi'
alias rm='rm -vi'
alias mkdir='mkdir -pv'
alias df='df -h'
alias du='du -h'

# for common mistakes
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'

# short git shortcuts
alias git-home='cd $(git rev-parse --show-toplevel)'
alias fetch='git fetch'
alias merge='git merge'
alias pull='git pull'
alias push='git push'
alias ga='git add'
alias gb='git branch'
alias gd='git diff'
alias gf='git fetch'
alias gh='git-home'
alias gk='git checkout'
alias gl='git log --graph --pretty=format:"%h %C(yellow)%ad %C(reset)- %C(green)%an%C(reset)%n%w(0,8,8)%B%n%N"'
alias glv='gl --stat-graph-width=$((${COLUMNS}/8))'
alias go='git commit'
alias grb='git rebase'
alias gs='git status -s'

# activity monitoring
alias top='top -o cpu'

# drive ejection
alias eject='hdiutil eject'

# stupid wifi
alias airport='networksetup -setairportpower en0'
alias toggle='airport off && airport on'
alias ping='ping -c 10'

# power button aliases
alias shutdown='sudo shutdown -h now'
alias restart='sudo shutdown -r now'
alias sleepytime='sudo shutdown -s now; sudo -k'

