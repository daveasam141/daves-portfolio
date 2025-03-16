```sh
kubectl apply -f homesite-deployment.yaml
kubectl get pod -n homesite 
kubectl get svc -n homesite 
kubectl get ing -n homesite 

### Chnage hostname in service and ingress section in deployment.yaml file 
```