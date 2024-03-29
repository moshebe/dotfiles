export GIT_AUTHOR="Moshe Beladev"

alias gl="git pull --rebase"
alias gwip="git wip && git push"

# gitignore.io
# gi list to get all supported types
function gi() {
	curl -L -s https://www.gitignore.io/api/$@
}

function changelog() {
	local d=$1
	local all=$2

	if [[ $all == "all" ]]
	then
		for repo in $(ls -d */ | cut -f1 -d'/')
		do
			if [ -d $repo/.git ]
			then
				cd $repo
				git log --author="${GIT_AUTHOR}" --pretty=format:"%h - %an, %ar : %s" --after="$d"
				cd ../
			fi
		done
	else
		git log --author="${GIT_AUTHOR}" --pretty=format:"%h - %an, %ar : %s" --after="$d"
	fi
}


# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

alias gti='git'
alias ga='git add'
alias gaa='git add --all'
alias gco='git checkout'
alias gd='git diff'
alias ggpull='git pull origin $(git_current_branch)'
alias ggpush='git push origin $(git_current_branch)'
alias gl="git pull --rebase"
alias glog="git log --graph --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short"
alias gfetch='git fetch --all'
alias glasttag='git describe --tags `git rev-list --tags --max-count=1`'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'