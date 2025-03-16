```sh 
### FALCO (installing falco through helm )
 Falco consumes from various event sources and evaluates pre-configured and user-defined rules to alert on malicious behaviour.  Its output system is also flexible to forward alerts to analysts through a variety of channels. Falco uses different instrumentations to analyze the system workload and pass security events to userspace.(The memeory space where all user actions and applications are executed ) We usually refer to these instrumentations as drivers((The global term for software that sends events from ther kernel)) since a driver runs in kernelspace(The memory space where the kernel executes and provides its services). he driver provides the syscall event source since the monitored events are strictly related to the syscall(Systemcalls: away to request calls from the runnning kermel context.

### Add Falco Helm repo 
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update

#### Default is to install DaemonSet
helm install falco falcosecurity/falco --create-namespace --namespace \
  falco --version 4.0.0 --set tty=true

### To download the chart with the eBPF probe. Or you can configure the ebpf driver by untarring the helm chart 
helm install falco falcosecurity/falco \
    --create-namespace \
    --namespace falco \
    --set driver.kind=ebpf 

### Edit the helm chart and set the default service to LoadBalancer so you can reach it with the loadbalancer ip 

### To deploy falco with custom values 
helm install falco falcosecurity/falco \
    --create-namespace \
    --namespace "your-custom-name-space" \
    -f "path-to-custom-values.yaml-file"
helm install falco falcosecurity/falco \
    --create-namespace \
    --namespace "falco" \
    -f "values.yaml"

########################################################################################################################
https://medium.com/stockbit-bibit-engineering/kubernetes-runtime-security-with-cncf-falco-on-amazon-eks-a42dad8e4bd0

#### Install Fission 
Fission is a serverless function framework to run active responses job inside Kubernetes Cluster
kubectl create namespace fission
kubectl create -k "github.com/fission/fission/crds/v1?ref=v1.16.0"
helm repo add fission-charts https://fission.github.io/fission-charts/
helm repo update
helm install --version v1.16.0 --namespace fission fission fission-charts/fission-all

### To check if the deployments was successful
kubectl get pods -n fission

### Create Service account file and apply file 
kubectl apply -f sa-falco-pod-delete.yaml

### Install Falco 
kubectl create namespace falco
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
helm upgrade --install falco falcosecurity/falco --namespace falco --set falcosidekick.config.fission.function="falco-pod-delete" --set falco.json_output=true --set driver.kind=ebpf --set falcosidekick.webui.enabled=true --set falcosidekick.enabled=true
kubectl patch daemonset falco --patch '{"spec":{"template":{"spec":{"$setElementOrder/containers":[{"name":"falco"}],"containers":[{"name":"falco","tty":true}]}}}}' --namespace falco

### Check to see of the deployment was successful
kubectl get pods -n falco

### Deploy a demo app
create yaml file for deploymemt 
source code: https://github.com/fadhilthomas/demo-kubernetes-runtime-security/blob/main/dvwa-app/dvwa-deployment.yaml
kubectl apply -f dvwa-deployment.yaml
kubectl get pods -n dvwa

### Falco’s Active Response Function
git clone https://github.com/fadhilthomas/demo-kubernetes-runtime-security.git
cd falcon-fission
fission spec apply


















```