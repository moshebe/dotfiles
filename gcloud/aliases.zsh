alias gcpctx='gcloud config get-value project'
function gcpset() {
	gcloud config set project $1	
}

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

