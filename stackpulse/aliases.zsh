SP_DIR="$GOPATH/src/github.com/stackpulse"

function runstep() {	
	step_path=$1
	step_dir="$SP_DIR/steps/steps/$step_path"
	env_file="$step_dir/.env"

	cd $step_dir
	branch_name=$(git rev-parse --abbrev-ref HEAD)
	cd - > /dev/null

	step_docker_img="us-docker.pkg.dev/stackpulse/public/$step_path:$branch_name"

	echo "running step: '$step_path'"
	docker run --rm --env-file "${env_file}" "${step_docker_img}"
}


function buildstep() {
	step_path=$1
	step_dir="steps/steps/$SP_DIR"
	formatted_step_path=$(echo $step_path | tr "/" -)

	echo "building step: '$formatted_step_path'"

	cd $SP_DIR/steps
	make build-${formatted_step_path}
	cd - > /dev/null
}

function stepimage() {
	step_path=$1
	step_dir="$SP_DIR/steps/steps/$step_path"

	cd $step_dir
	branch_name=$(git rev-parse --abbrev-ref HEAD)
	cd - > /dev/null

	step_docker_img="us-docker.pkg.dev/stackpulse/public/$step_path:$branch_name"
	echo "$step_docker_img"
}


alias jiratrello='~/Dev/gosync/gosync ~/Dev/gosync/config.yml.example'
alias jsprint="open \"https://stackpulse.atlassian.net/secure/RapidBoard.jspa?rapidView=10&projectKey=SP&selectedIssue=SP-7268&assignee=601fa3fef6e6c50069e2c7c0\""
alias gcpdev='gcpset stackpulse-development'
alias gcpstage='gcpset stackpulse-staging'
alias gcpprod='gcpset stackpulse-production'
alias gcpdemo='gcpset stackpulse-demo'


alias localdkron='kubectl -n dkron port-forward service/dkron 8080:8080'

function parseawssecrets() {
	encoded_secret=$1
    echo $encoded_secret | base64 -D | grep AWS
}

function forcemakedev() {
	project=$(basename $PWD)
	gsutil rm gs://stackpulse-development/$project.tplock ; make dev
}

function openci() {
	project=$1
	if [ -z "$project" ]; then
		project=$(basename $PWD)
	fi
	open "https://app.circleci.com/pipelines/github/torqio/$project"
}

function opengh() {
	project=$1
	if [ -z "$project" ]; then
		project=$(basename $PWD)
	fi
	open "https://github.com/torqio/$project"
}

function spcd() {
	cd $GOPATH/src/github.com/stackpulse/$1
}

function tqcd() {
	cd $HOME/Dev/torqio/$1
}

alias tqfetch='tqcd && for d in *; do echo $d && tqcd $d && git fetch --all; cd - >/dev/null; done'
