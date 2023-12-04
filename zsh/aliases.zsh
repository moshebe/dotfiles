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

alias new-uuid="uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\n'"

alias finnotify="curl https://agile-wildwood-94022.herokuapp.com/run"

alias daily-update="b; gcloud components update --quiet"