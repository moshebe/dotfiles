# Go packages to install
readonly PACKAGES=(
	golang.org/x/tools/gopls@latest
	github.com/bufbuild/buf-language-server/cmd/bufls@latest
	golang.org/x/tools/cmd/goimports@latest
	github.com/golang/mock/mockgen@latest
	github.com/go-jira/jira/cmd/jira@latest
	github.com/go-delve/delve/cmd/dlv@latest
)

if which go > /dev/null 2>&1
then
	for pkg in ${PACKAGES[@]}
	do
		go install $pkg
	done
fi
