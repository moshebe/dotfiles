alias k='kubectl config use-context'
alias kca='kubectl get --all-namespaces'

alias kbl='kubectl'
alias ksp='kubectl -n stackpulse'
alias kblctx='kubectl config current-context'

function kblrename() {
	kubectl config rename-context $1 $2
}