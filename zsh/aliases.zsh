# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# Modern replacements
alias ls='exa'                                                          # Modern ls
alias l='exa -lbF'                                                     # List, size, type
alias ll='exa -lbGF'                                                   # Long list
alias llm='exa -lbGF --sort=modified'                                 # Long list, modified date sort
alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale' # All list
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # All + extended list
alias tree='exa --tree'                                               # Tree view
alias find='fd'                                                       # Modern find
alias top='htop'                                                      # Modern top
alias du='dust'                                                       # Modern du
alias df='duf'                                                        # Modern df
alias ps='procs'                                                      # Modern ps

# Git
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gco='git checkout'
alias gd='git diff'
alias gf='git fetch'
alias gl='git pull'
alias gp='git push'
alias gst='git status'
alias glog='git log --oneline --decorate --graph'

# Docker
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dprune='docker system prune -af'

# Kubernetes
alias k='kubectl config use-context'
alias kx='kubectx'
alias kn='kubens'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kl='kubectl logs'
alias kex='kubectl exec -it'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgi='kubectl get ingress'

# Terraform
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfw='terraform workspace'
alias tfws='terraform workspace select'
alias tfwl='terraform workspace list'

# Development
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias py='python3'
# Note: pip, node, npm are lazy-loaded via zsh/lazy-load.zsh
# Do not alias them here or it will conflict with lazy-loading
alias pn='pnpm'
alias yarn='yarn'

# System
alias reload!='source ~/.zshrc'
alias path='echo -e ${PATH//:/\\n}'
alias ports='lsof -i -P -n | grep LISTEN'
alias myip='curl http://ipecho.net/plain; echo'
alias localip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias cpwd='pwd | pbcopy'
alias mkdir='mkdir -p'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias please='sudo'
alias weather='curl wttr.in'

# Network
alias ping='ping -c 5'
alias wget='wget -c'
alias curl='curl -L'
alias hosts='sudo nvim /etc/hosts'
alias ports='netstat -tulanp'

# Utilities
alias c='clear'
alias h='history'
alias j='jobs -l'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias week='date +%V'
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Directory shortcuts
alias dotfiles='cd $DOTFILES'
alias workspace='cd $WORKSPACE'
alias dev='cd $DEVDIR'
alias downloads='cd ~/Downloads'
alias desktop='cd ~/Desktop'
alias documents='cd ~/Documents'

# Quick edits
alias zshrc='${EDITOR} ~/.zshrc'
alias vimrc='${EDITOR} ~/.config/nvim/init.lua'
alias gitconfig='${EDITOR} ~/.gitconfig'
alias hosts='sudo ${EDITOR} /etc/hosts'

# Misc
alias update='brew update && brew upgrade && brew cleanup'
alias cleanup='brew cleanup && docker system prune -f'
alias cls='clear'
