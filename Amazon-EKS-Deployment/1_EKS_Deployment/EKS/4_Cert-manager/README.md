### Cert-Manager 

Cert-Manager is a powerful tool that simplifies the management of SSL/TLS certificates in Kubernetes. By automating certificate provisioning and renewal, it ensures your applications communicate securely and reliably. 

```sh
### 1. Install cert-manager
### cert-manager is a CRD (Custom Resource Definition) that dynamically generates TLS/SSL certificates for our applications using Let’s Encrypt (although it also supports other issuers).

helm repo add bitnami https://charts.bitnami.com/bitnami
helm install --create-namespace -n cert-manager cert-manager bitnami/cert-manager \
  --create-namespace \
  --namespace cert-manager \
  --set installCRDs=true

### 2. Install Let's Encrypt
### Note: Replace <my_email> with your email address. If you’re using an Ingress other than Nginx, you need to change the manifests above by setting the appropriate class.
### Run the command below to create them in the cluster.
kubectl apply -f cert-manager-staging.yaml -f cert-manager-prod.yaml 

### To check to see if Let's Encrypt was installed correctly 

### To delete namespace 
kubectl delete namespace (Namespace)

*** Note: Make sure your'e working in the right directory 

