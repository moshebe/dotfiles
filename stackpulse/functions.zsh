function parseawssecrets() {
	encoded_secret=$1
    echo $encoded_secret | base64 -D | grep AWS
}

function jt() {
	input=$1
	ticket=`echo $1 | tr '[:lower:]' '[:upper:]'`


	if [[ ! "$ticket" =~ ^SP-.* ]]; then
        	ticket="SP-${ticket}"
	fi

	open https://stackpulse.atlassian.net/browse/$ticket
}


makedevf() {
	USERNAME="Moshe Beladev"
	OUT_PATH=/tmp/makedev.log
	make fmt
	make dev 2>&1 > $OUT_PATH

	if ! grep "is locked by other user" $OUT_PATH; then
		echo "[V] done."
    	return
	fi

	if ! grep "User: $USERNAME" $OUT_PATH > /dev/null
	then
		unlock_cmd=$(grep "gsutil rm gs://stackpulse-development" $OUT_PATH)
		echo "You acquired the lock, releasing..."
		eval $unlock_cmd		
		makedevf
	else
   		echo "The lock was acquired by another $(grep "User: " $OUT_PATH), be patience..."
		return		
	fi
}

versioncheck() {
 kube_env="${1:-prod}"
 service="$2"
 
 if [ $service == "."  ]; then
     service=$(basename $(pwd))
 fi
 
 if [ -z "$service" ]
 then
     echo "Error: no service"
     return
 fi
 
 echo "> Fetching status for service $service on $kube_env"
 
 tqcd $service
 gfetch > /dev/null
 lastest_tag=$(glasttag)
 latest_tag_commit=$(tag2commit $lastest_tag)
 
 canary_image=$(kubectl --context ${kube_env} describe deploy/$service | grep "$service:" | grep Image: | awk '{print $2}')
 canary_image_ref=${canary_image##*:}
 canary_image=${canary_image_ref##*-}
 
 primary_image=$(kubectl --context ${kube_env} describe deploy/$service-primary | grep "$service:" | grep Image: | awk '{print $2}')
 primary_image_ref=${primary_image##*:}
 primary_git_ref=${primary_image_ref##*-}
 
 echo "============================================================"
 echo "Latest version: $latest_tag ($latest_tag_commit)"
 echo "Canary version: $canary_image"
 echo "Primary version: $primary_git_ref"
 echo "============================================================"
 glog -10 --all
}

function orch-versioncheck() {
	versioncheck ${1:-prod} playbook-orchestrator
}

spd-versioncheck() {
 kube_env="${1:-prod}"
 service="spd"
 
 echo "> Fetching status for service $service on $kube_env"
 
 tqcd $service
 gfetch > /dev/null
 lastest_tag=$(glasttag)
 latest_tag_commit=$(tag2commit $lastest_tag)
 
 primary_image=$(kubectl --context ${kube_env} describe sts/$service | grep "$service:" | grep Image: | awk '{print $2}')
 primary_image_ref=${primary_image##*:}
 primary_git_ref=${primary_image_ref##*-}
 
 echo "============================================================"
 echo "Latest version: $latest_tag ($latest_tag_commit)"
 echo "Primary version: $primary_git_ref"
 echo "============================================================"
 glog -10 --all
}

orch-run-inttests() {
	cd "$HOME/Dev/torqio/playbook-orchestrator/internal/testing"
	go test -v --update-golden-steps --ignore-generated-fields ./...
	echo "====== Changed golden files: ======"
	git st | grep -E "testdata/.*golden.*"
}

function translate_project_name() {
	project=$1
	case $project in
		prd | prod | production)
			project="stackpulse-production"
		;;
		stg | stage | staging)
			project="stackpulse-staging"
		;;
		dev | development)
			project="stackpulse-development"
		;;
	esac

	echo $project
}

open-error-report() {
	project=$(translate_project_name $1)
	open "https://console.cloud.google.com/errors?time=P30D&order=LAST_SEEN_DESC&resolution=OPEN&resolution=ACKNOWLEDGED&project=$project"
}

open-tracing() {
	project=$(translate_project_name $1)
	open "https://console.cloud.google.com/traces/list?project=$project"
}