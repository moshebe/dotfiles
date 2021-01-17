export GIT_AUTHOR="Moshe Beladev"

alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gl="git pull --rebase"
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'
alias ggpush='git push origin $(git_current_branch)'
alias ggpull='git pull origin $(git_current_branch)'

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
				git log --author=${GIT_AUTHOR} --pretty=format:"%h - %an, %ar : %s" --after="$d"
				cd ../
			fi
		done
	else
		git log --author=${GIT_AUTHOR} --pretty=format:"%h - %an, %ar : %s" --after="$d"
	fi
}
