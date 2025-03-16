### Deploying falco sidekick with helm 
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
helm install falcosidekick --set config.debug=true falcosecurity/falcosidekick --namespace falco2 --create-namespace

### Verify that the falcosidekick pod is running 
k get pods -n falco2

### Port forward to reach the falcosidekick ui from web browser 
kubectl port-forward  falco-falcosidekick-ui-8556b688d8-jrrxw  2802:2802 -n falco2 (must include the ns to find the pod)

### UI login credentials 
username:
password: