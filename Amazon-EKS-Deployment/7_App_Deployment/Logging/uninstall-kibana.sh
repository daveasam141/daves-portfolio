helm uninstall kibana -n elastic-system
kubectl delete configmap kibana-kibana-helm-scripts  -n elastic-system 
kubectl delete serviceaccount pre-install-kibana-kibana  -n elastic-system 
kubectl delete roles pre-install-kibana-kibana  -n elastic-system 
kubectl delete rolebindings pre-install-kibana-kibana  -n elastic-system 
kubectl delete job pre-install-kibana-kibana  -n elastic-system

for pod in `kubectl get pod -n elastic-system --no-headers |grep post | awk '{print $1}'`; do kubectl delete pod $pod -n elastic-system; done