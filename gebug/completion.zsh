if which gebug > /dev/null 2>&1
then
	source <(gebug completion zsh && echo "compdef _gebug gebug")
fi
