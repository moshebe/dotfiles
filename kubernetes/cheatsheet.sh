# get credentials
gcloud container clusters get-credentials <cluster> --region <region> --project <project>

# get current context name
kubectl config current-context

# rename the long google context
kubectl config rename-context <context_name> dev

# switch between dev and prod contexts
kubectl config use-context dev
kubectl config use-context prd

# get all application pods
kubectl get pods
kubectl -n <namespace> get pods

# get pods using labels
kubectl -n <namespace> get pods -l app=account-service

# read pod logs
kubectl -n <namespace> logs <pod_id>

# restart application
kubectl -n <namespace> rollout restart deploy/<app_name> # kubectl 1.15+
kubectl -n <namespace> delete pod -l app=<app_name>

# scale up/down application
kubectl -n <namespace> scale deployment <app_name> --replicas 3

# run a job from a cronjob template
kubectl -n <namespace> create job <cronjob-name>-$(date +%s) --from cronjob/<cronjob-name>

# list all cronjobs
kubectl -n <namespace> get cronjobsf