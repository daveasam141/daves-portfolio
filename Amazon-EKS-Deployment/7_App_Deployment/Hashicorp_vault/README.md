```sh 
### Create a configuration file to configure Vault installation.
server:
  standalone:
    enabled: true
    config: |
      ui = true
      listener "tcp" {
        tls_disable = 1
        address = "[::]:8200"
        cluster_address = "[::]:8201"
      }
      storage "file" {
        path = "/vault/data"
      }
  service:
    enabled: true
ui:
  enabled: true
  serviceType: Loadbalancer 

### Create namespace for deployment
kubectl create ns vault

### To access the Vault Helm chart, add the Hashicorp Helm repository.
helm repo add hashicorp https://helm.releases.hashicorp.com

### Install the Vault helm chart.
helm install vault hashicorp/vault --namespace vault --create-namespace -f values.yaml 
helm install vault hashicorp/vault

### To get clusterrole 
k get clusteroles

### To delete cluster role 
k delete clusterrole (nameofclusterrole)

### To get clsuter role binding 
k get clusterrolebinding 

### To delete clusterrolebinding 
k delete clusterrolebinding(nameofclusterrolebinding)

### To clean up if helm unistall leaves residue behind 
kubectl delete mutatingwebhookconfiguration vault-agent-injector-cfg
kubectl delete clusterrolebinding vault-server-binding
kubectl delete clusterrolebinding vault-agent-injector-binding
kubectl delete clusterrole vault-agent-injector-clusterrole

### key 







```