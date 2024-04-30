# begin working with gcloud
gcloud init

# generate token for local apps (terraform etc.)
gcloud auth application-default login

# configure docker auth
gcloud auth configure-docker gcr.io,us-docker.pkg.dev
 
# list url-maps (load balancers)
gcloud compute url-maps list

# invalidate cache
gcloud compute url-maps invalidate-cdn-cache [URL_MAP_NAME] --path "/images/*"

# accessing the database (get the password from k8s secrets)
gcloud beta sql connect  stackpulsedb --user=<user> --database=<db> --project <project>