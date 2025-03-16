```sh 
### deployment (if you dont have the k alias set replace k with kubectl. These commands won't work of you do not have the k alias set)
k apply -f pvc.yaml
k apply -f deployment.yaml
k apply -f service.yaml
k apply -f ingress.yaml


### Check check deployment, pods and services 
k get deployments -n default
k get pvc -A
k get service -A
k get ingress -A
*** make sure the objects are in the right places












```