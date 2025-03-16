```sh
### Add atlassian helm repo to local helm repo 
helm repo add atlassian-data-center \
 https://atlassian.github.io/data-center-helm-charts
helm repo update

### Installing confluence 
helm upgrade -i confluence atlassian-data-center/confluence --namespace confluence --create-namespace  --values confluence-values.yaml
kubectl get pod -n confluence
kubectl get svc -n confluence
kubectl describe pod confluence-0 -n confluence
kubectl get ing -n confluence
kubectl get pod -n confluence -w
kubectl logs confluence-0 -n confluence

### You can install confluence using a script (install-confluence.sh it is one of the files in the repo. To run the script, it must have execute permissions)
./install-confluence.sh 

### To delete a confluence
helm uninstall confluence -n confluence
kubectl delete ns confluence

### You can also delete confluence with a script (uninstall-confluence.sh it is also one of the files in the repo. TO use this script it must have execute permissions)
./uninstall-confluence.sh 

aws rds describe-db-instances --db-instance-identifier jiradb | jq '.DBInstances[].Endpoint.Address's
```