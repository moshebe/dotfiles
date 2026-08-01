autoload colors && colors

# Async git prompt (background subprocess, no blocking on every keypress)
source ${0:A:h}/git-prompt.zsh

# GCP prompt: watches config file mtime, colors by environment
# production → red, staging → yellow, other → cyan
source ${0:A:h}/gcloud-prompt.zsh

RPROMPT='%{$fg[$ZSH_GCLOUD_PROMPT_COLOR]%}($ZSH_GCLOUD_PROMPT)%{$reset_color%}'
