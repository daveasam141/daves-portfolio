### For Mac - Install Argo CLI 
brew install argocd

### Install Argo CD to the cluster
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

### The password is auto-generated, we can get it with:
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
passwd:(insert)

### Accessing the Argo CD Web UI
kubectl port-forward svc/argocd-server -n argocd 8080:443

kubectl get po -n argocd
kubectl get svc -n argocd
kubectl get ing -n argocd

#### or use this method after installing argocd to retrieve paswd and log in (make sure to change the password in subsequent commmands, using the password in the output from running line 24)
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}' > /dev/null 2>&1 
export argo_url=$(kubectl get svc -n argocd | grep argocd-server | awk '{print $4}' | grep -v none)
echo "argo_url: http://$argo_url/"
echo username: "admin"
echo password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) 

### To log into argocd thriugh command line to connect it with the ui so you can deploy from git with argo from CL instead of ui
argocd login 127.0.0.1:8080 --username admin --password (insert) --insecure

### You can log into argocd ui on your web browser using your loadbalancer address just make sure to log into argocd from cli first 

###  To sync an argocd deployment using cli 
argocd --port-forward --port-forward-namespace=argocd app sync (appname)

### To log into argocd through command line to connect it with the ui so you can deploy from git with argo from CLI instead of ui
argocd login 127.0.0.1:8080 --username admin --password (insert) --insecure

### How to  deploy an app with argocd (change the repo to a repo you create for your argocd deployment)
argocd --port-forward --port-forward-namespace=argocd app create homesite --repo https://github.com/daveasam141/argocd-config-demo.git --path homesite --dest-server https://kubernetes.default.svc --dest-namespace argocd

### If your're getting a connection refused error with argocd include port forward in every argocd command 
argocd --port-forward --port-forward-namespace=argocd login --username=admin --password=(insert)

### Apps deployed with argocd can be deleted with cascade and without it. (cascade removes all the resources related to the application as well)
To perform a non cascade remove: argocd app delete APPNAME --cascade=false

### To delete using cascade 
argocd app delete APPNAME --cascade OR argocd app delete APPNAME
argocd --port-forward --port-forward-namespace=argocd app delete homesite 

### To get argocd app 
argocd --port-forward --port-forward-namespace=argocd app get homesite 

### How to deploy an app with argocd (change the github repo toone that you create for your own deployment )
argocd --port-forward --port-forward-namespace=argocd app create homesite --repo https://github.com/daveasam141/argocd-config-demo.git --path homesite --dest-server https://kubernetes.default.svc --dest-namespace argocd
argocd  app create homesite --repo https://github.com/daveasam141/argocd-config-demo.git --path argocdbranch/homesite --dest-server https://kubernetes.default.svc --dest-namespace argocd

### How to deploy an app on argocd using a different branch other than the main branch (make sure to change the repo to yours)
argocd --port-forward --port-forward-namespace=argocd app create homesite --repo https://github.com/daveasam141/argocd-config-demo.git --revision argocdbranch --path homesite --dest-server https://kubernetes.default.svc --dest-namespace argocd

### If your're getting a connection refused error with argocd include port forward in every argocd command 
argocd --port-forward --port-forward-namespace=argocd login --username=admin --password=(insert)

### To rollback an application on argocd 
First list your apps on argocd: argocd --port-forward --port-forward-namespace=argocd app list 

### To check deployment history 
argocd --port-forward --port-forward-namespace=argocd app history <app-name>

### To rollback to last successful state(Rollback cannot be performed against an application with automated sync enabled.)
argocd --port-forward --port-forward-namespace=argocd app rollback homesite 0
argocd --port-forward --port-forward-namespace=argocd app rollback homesite - revision=0

### To enable auto-sync on argocd 
argocd --port-forward --port-forward-namespace=argocd app set <APPNAME> --sync-policy automatedn 
OR adding the following lines to the argocd application manifest:
spec:
  syncPolicy:
    automated: {}

### To enable auto-sync with auto-pruning (pruning automatically deletes the older resorces not longer defined in git after auto-sync has happened )
argocd --port-forward --port-forward-namespace=argocd  app set <APPNAME> --auto-prune
OR by setting the prune option to true in the automated sync policy using the following lines:
spec:
  syncPolicy:
    automated:
      prune: true

### By default, changes that are made to the live cluster will not trigger automated sync. To enable automatic sync when the live cluster's state deviates from the state defined in Git, run:
argocd --port-forward --port-forward-namespace=argocd app set <APPNAME> --self-heal
Or by setting the self heal option to true in the automated sync policy:
spec:
  syncPolicy:
    automated:
      selfHeal: true


### Deploying an application on argocd using helm charts 
When deploying a Helm application Argo CD is using Helm only as a template mechanism. It runs helm template and then deploys the resulting manifests on the cluster instead of doing helm install. This means that you cannot use any Helm command to view/verify the application. It is fully managed by Argo CD

### Create helm chart and push it to remote repo (you would have to create your own helm chart and push it to github)
repo url: https://github.com/daveasam141/helm-charts.git

### Specify repo url in argocd app create command. The chart can also be installed in a declarative way using a manifest (see link pastedn on line 103)
argocd --port-forward --port-forward-namespace=argocd app create homesite --repo https://github.com/daveasam141/helm-charts.git --path homesite --dest-server https://kubernetes.default.svc --dest-namespace argocd
https://medium.com/@harshaljethwa19/deploying-an-application-to-argocd-using-helm-part-2-of-ci-cd-using-argocd-cd6a6c7a3047

### You might need to manually sync the application if auto-sync isn't enabled 
argocd --port-forward --port-forward-namespace=argocd app sync (appname)

### Setting up notifications in argocd 

### Downloading triggers and template for argocd notifications 
kubectl apply -n argocd -f \
https://raw.githubusercontent.com/argoproj-labs/argocd-notifications/release-1.0/catalog/install.yaml

### To validate that the templates and triggers have been added to the configmap he Argo CD Notifications ConfigMap centralizes and manages notifications settings, facilitating easy customization and updates of deployment event notifications within ArgoCD.
kubectl get cm argocd-notifications-cm -n <argocd-namespace> -o yaml

### Add slack notification token (include your own slack token)
kubectl patch secret argocd-notifications-secret -n argocd \
 --type merge --patch '{"stringData":{"slack-token": "insert your own slack token"}}'

### To verify that the slack token has been successfully added to the secret (The Slack token will be encoded in the Secret, ensuring its security)
 kubectl get secret argocd-notifications-secret -n argocd -o yaml

### Configure Slack integration in the argocd-notifications-cm ConfigMap. add Slack Notifications Service along with reference to your Slack token in argocd-notifications-cm ConfigMap with below command:
kubectl patch configmap argocd-notifications-cm -n argocd --type merge -p '{"data": {"service.slack": "token: $slack-token"}}'

### To deploy an argocd application to test if notifications will send to slack 
argocd --port-forward --port-forward-namespace=argocd app create homesite --repo https://github.com/daveasam141/argocd-config-demo.git\
  --path homesite --dest-namespace argocd \
  --dest-server https://kubernetes.default.svc --directory-recurse \
  --annotations notifications.argoproj.io/subscribe.on-sync-succeeded.slack=(yourslackchannel)



### Slack user Oauth token 
(you woukd have to create yours)


### Download argo

### References 
https://argo-cd.readthedocs.io/en/latest/user-guide/app_deletion/
https://raw.githubusercontent.com/argoproj-labs/argocd-notifications/release-1.0/catalog/install.yaml
https://medium.com/@harshaljethwa19/deploying-an-application-to-argocd-using-helm-part-2-of-ci-cd-using-argocd-cd6a6c7a3047