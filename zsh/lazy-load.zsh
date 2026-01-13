# Lazy-loading helpers for faster shell startup
# This file provides functions to defer loading of heavy tools until they're actually needed

# Lazy load NVM (Node Version Manager)
# This saves ~1.5s on startup by only loading NVM when node/npm/npx is called
lazy_load_nvm() {
  unset -f node npm npx nvm 2>/dev/null
  export NVM_DIR="$HOME/.nvm"

  # Load nvm
  [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
  [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
}

# Create placeholder functions that trigger NVM loading
# Unalias first in case there are any aliases
unalias node npm npx nvm 2>/dev/null

node() {
  lazy_load_nvm
  command node "$@"
}

npm() {
  lazy_load_nvm
  command npm "$@"
}

npx() {
  lazy_load_nvm
  command npx "$@"
}

nvm() {
  lazy_load_nvm
  nvm "$@"
}

# Lazy load jenv (Java Environment Manager)
lazy_load_jenv() {
  unset -f java javac jenv 2>/dev/null
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
  export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"
}

if [ -d "$HOME/.jenv" ]; then
  unalias java javac jenv 2>/dev/null

  java() {
    lazy_load_jenv
    command java "$@"
  }

  javac() {
    lazy_load_jenv
    command javac "$@"
  }

  jenv() {
    lazy_load_jenv
    jenv "$@"
  }
fi

# Lazy load pyenv (Python Version Manager)
lazy_load_pyenv() {
  unset -f python python3 pip pip3 pyenv 2>/dev/null
  if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
  fi
}

if command -v pyenv 1>/dev/null 2>&1; then
  unalias python python3 pip pip3 pyenv 2>/dev/null

  python() {
    lazy_load_pyenv
    command python "$@"
  }

  python3() {
    lazy_load_pyenv
    command python3 "$@"
  }

  pip() {
    lazy_load_pyenv
    command pip "$@"
  }

  pip3() {
    lazy_load_pyenv
    command pip3 "$@"
  }

  pyenv() {
    lazy_load_pyenv
    pyenv "$@"
  }
fi

# Lazy load Google Cloud SDK
lazy_load_gcloud() {
  unset -f gcloud gsutil bq 2>/dev/null

  # Check if gcloud is installed via Homebrew
  if [ -f "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ]; then
    source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
    source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
  fi
}

if [ -f "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ]; then
  unalias gcloud gsutil bq 2>/dev/null

  gcloud() {
    lazy_load_gcloud
    command gcloud "$@"
  }

  gsutil() {
    lazy_load_gcloud
    command gsutil "$@"
  }

  bq() {
    lazy_load_gcloud
    command bq "$@"
  }
fi
