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

alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

alias dbdevproxy="cloud_sql_proxy -instances=stackpulse-development:europe-west1:stackpulsedb=tcp:5432"
alias dbpass="kubectl get secret/stackpulsedb -o json | jq -r .data.DB_PASSWORD | base64 --decode"

alias pip=pip3
alias python=python3

alias vi=nvim
