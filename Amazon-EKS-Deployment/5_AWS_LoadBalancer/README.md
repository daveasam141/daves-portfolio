Application Load Balancer components

A load balancer serves as the single point of contact for clients. The load balancer distributes incoming application traffic across multiple targets, such as EKS, EC2 instances. This increases the availability of your application. You add one or more listeners to your load balancer. It scales resources and automatically distributes incoming application traffic to handle heavy traffic demands.

A listener checks for connection requests from clients, using the protocol and port that you configure. The rules that you define for a listener determine how the load balancer routes requests to its registered targets. 

```sh
### Installing a load balancer

### Add the eks-charts Helm chart repository.
helm repo add eks https://aws.github.io/eks-charts

### Update your local repo to make sure that you have the most recent charts.
helm repo update eks

### Install the AWS Load Balancer Controller. Replace my-cluster with the name of your cluster.
helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=eks-cluster-1

### Verify that the controller is installed
kubectl get po --all-namespaces | grep aws-load-balancer-controller
kubectl get deployment -n kube-system aws-load-balancer-controller
```