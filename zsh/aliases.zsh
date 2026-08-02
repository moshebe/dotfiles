alias reload!=". ~/.zshrc"
alias ..="cd .."
alias ...="cd ../.."

alias ll='ls -alF'
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias path='echo -e ${PATH//:/\\n}'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias urlencode='python3 -c "import sys, urllib.parse as up; print(up.quote_plus(sys.argv[1]))"'
alias urldecode='python3 -c "import sys, urllib.parse as up; print(up.unquote_plus(sys.argv[1]))"'
alias num-humanize='numfmt --to=iec'

alias new-uuid="uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\n'"

alias gd="git diff"

alias daily-update="b; gcloud components update --quiet"

alias claude-whoami='echo "profile: $(cat $DOTFILES/zsh/claude-profiles/.active 2>/dev/null || echo none)"; echo "key:     ${ANTHROPIC_API_KEY:0:20}..."'
