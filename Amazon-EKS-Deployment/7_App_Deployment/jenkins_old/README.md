

```sh
kubectl apply -f namespace.yaml
kubectl apply -f pvc.yaml
kubectl apply -f configmap.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
kubectl get po -n jenkins
```
#####################
### For helm chart installation  
helm repo add jenkins https://charts.jenkins.io
helm repo update
helm install myjenkins jenkins/jenkins --namespace jenkins --create-namespace 
kubectl patch svc jenkins -n jenkins -p '{"spec": {"type": "LoadBalancer"}}' > /dev/null 2>&1 
kubectl get svc -n jenkins

### to see helm values 
helm pull jenkins/jenkins --untar (if you edit thos values file make sure to include it when installing the helm chart)
: helm install myjenkins jenkins/jenkins --namespace jenkins --create-namespace -f (value file)