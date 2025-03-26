### check pods 
k get pods -n 

### Describe pods 
k describe pods -n 

### get logs for pods 
k logs -n <pod_name>

### check logs for svc 
k logs <svcname> -n <ns>

### Check logs for ingress conreoller and loadBalancer 


### Check service
k get svc -n 

### describe svc 
k describe svc -n (might have to specify svc name) 

### If using ingress
check loadbalancer make sure it has the right targets
make sure right ports are open for loadbalancer 
healthcheck for loadbalancer
make sure ingress is routing to the right loadbalancer 
create a temp pod to test if svc is reachable inside cluster: kubectl run -it --rm debug --image=busybox --restart=Never -- sh then:wget -qO- http://homesite.homesite.svc.cluster.local see if you can reach the svc would have to change values
nslookup domainname to make sure its routing to the right loadbalancer which is pointing to the right target group

### launch a pod that has more linux utilities in the same pods ns

### log into  the pod
k exec -it <podname> -n <ns> -- /bin/sh