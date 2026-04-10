if command -v terraform &>/dev/null; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C terraform terraform
fi
