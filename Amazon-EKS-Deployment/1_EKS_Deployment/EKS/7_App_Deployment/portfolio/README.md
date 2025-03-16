### Verify that everything is working

```sh
### Deploy your first application on Kubernetes
kubectl apply -f namespace.yaml 
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml 

### Verify application health and behavior 
kubectl get deploy -n homesite 
kubectl get po -n homesite 
kubectl get svc -n homesite 
kubectl get ing -n homesite 
kubectl describe -n homesite 

### Delete your app
kubectl delete -f deployment.yaml 
kubectl delete -f service.yaml 
kubectl delete -f ingress.yaml 

### Second method 
### deploy your website on kube cluster 

Run command 
```shell 
kubectl apply -k ./
kubectl get pod -n homesite
kubectl get pv -n homesite
kubectl get pvc -n homesite
kubectl get deployments -n homesite
kubectl get ing -n homesite
kubectl get svc -n homesite

### Deploy using kustomization
kubectl apply -k ./
kubectl apply -k ./homesite

### Cleanup
Run command 
kubectl delete -k ./
kubectl get ns 
```