```sh 
### Installing kube-bench with prometheus, grafana etc
git clone https://github.com/ibrokethecloud/kube-bench-metrics

### Install kube-bench 
helm repo add deliveryhero https://charts.deliveryhero.io/
helm repo update 
helm install kube-bench deliveryhero/kube-bench -f values.yaml --namespace kube-bench --create-namespace 
































```