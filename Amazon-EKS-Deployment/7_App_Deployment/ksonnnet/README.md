#### KSONNET 
ksonnet is a framework for writing, sharing, and deploying Kubernetes application manifests. With its CLI, you can generate a complete application from scratch in only a few commands, or manage a complex system at scale.

Specifically, ksonnet allows you to:

Reuse common manifest patterns (within your app or from external libraries)
Customize manifests directly with powerful object concatenation syntax
Deploy app manifests to multiple environments
Diff across environments to compare two running versions of your app
Track the entire state of your app configuration in version controllable files
All of this results in a more iterative process for developing manifests, one that can be supplemented by continuous integration (CI).

### Installing ksonnet 
brew install ksonnet/tap/ks

### To create a ksonnet app directory 
# The ks-example app directory is created at the current path, and the
# app itself references your current cluster using $KUBECONFIG
ks init ks-example

### cd into your app directory 
cd ks-example

##################################################################
### Installing kube-metrics, prometheus, alertmanager, and grafana 
to access grafana ui we  need emissary-ingress:Emissary-Ingress is an open-source Kubernetes-native API Gateway + Layer 7 load balancer + Kubernetes Ingress built on Envoy Proxy. (kind of like an nginx ingress controller )

### To install emissary-ingress with helm 
# Add helm repo
helm repo add datawire https://app.getambassador.io
helm repo update

# Create namespace and install 
kubectl create namespace emissary && \
kubectl apply -f https://app.getambassador.io/yaml/emissary/3.9.1/emissary-crds.yaml

kubectl wait --timeout=90s --for=condition=available deployment emissary-apiext -n emissary-system


helm install emissary-ingress --namespace emissary datawire/emissary-ingress && \
kubectl -n emissary wait --for condition=available --timeout=90s deploy -lapp.kubernetes.io/instance=emissary-ingress







### Refereneces 
https://github.com/ksonnet/ksonnet