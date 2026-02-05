if [ -f "$BREW_PATH/share/google-cloud-sdk/completion.zsh.inc" ]; then
  source "$BREW_PATH/share/google-cloud-sdk/completion.zsh.inc"
fi

function __g {
	_arguments "1: :($(gcloud config configurations list --format='value(name)'))"
}

compdef __g g