### Ingress Controller

To get traffic into your Kubernetes cluster, you need an ingress controller. 

What is Kubernetes Ingress?
Kubernetes ingress is a collection of routing rules that govern how external users access services running in a Kubernetes cluster.

A typical Kubernetes application has pods running inside a cluster and a load balancer outside. The load balancer takes connections from the internet and routes the traffic to a proxy that sits inside your cluster. This proxy is then responsible for routing traffic into your pods. 

```sh
### ### Installing Ingress Controller
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace

### Verify it installed
kubectl get po -n ingress-nginx
kubectl get svc -n ingress-nginx
kubectl get ing -n ingress-nginx

# Upgrading ingress controller
#Make sure to have ingress-nginx repo 
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
![alt text](<screenshots/Screenshot 2025-03-26 at 4.53.17 PM.png>)

# run helm upgrade command to upgrade repo 
helm upgrade --reuse-values ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx
![alt text](<screenshots/Screenshot 2025-03-26 at 4.58.07 PM.png>)

```