```sh 
##### Deploying Vault using Helm 
### Install vaultcli 
brew tap hashicorp/tap
brew install hashicorp/tap/vault

#Add the vault helm repository:
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update


### Install vault in development mode for testing 
helm install vault hashicorp/vault --set "server.dev.enabled=true"
![alt text](<screenshots/Screenshot 2025-03-17 at 9.55.28 PM.png>)

### Access vault via port-forward(for testing purposes)
kubectl port-forward svc/vault 8200:8200
kubectl exec -it vault-0  -n default -- cat /var/run/secrets/kubernetes.io/serviceaccount/token


### Logging into vault 
export VAULT_ADDR=http://127.0.0.1:8200
vault login root



vault write auth/kubernetes/role/vault-role \
   bound_service_account_names=vault \
   bound_service_account_namespaces=vault \
   policies=read-policy \
   ttl=1h














```
kubectl get secret sh.helm.release.v1.vault.v1 -n default -o=jsonpath='{.data.release}' | base64 --decode