```sh
## 1. Create a Cluster
eksctl create cluster --name  daves-cluster --node-type t3a.xlarge 
kubectl get nodes -o wide |  awk {'print $1" " $2 " " $7'} | column -t
kubectl get nodes -o wide 
eksctl create cluster --name daves-cluster --version 1.31 --nodes 3 --node-type t3.meduim

# --ssh-access --ssh-public-key=~/.ssh/id_ed25519.pub

### To specify the number of nodes in the cluster; run the following command:
eksctl create cluster --name eks-cluster --nodes 3 --node-type m5.xlarge

### Specification
- Recommended node group specification: three nodes with 4 CPU’s and 16GiB memory each
- eg. m5.xlarge EC2 instances to fulfill requirements
- Replace the region-code with your AWS Region of choice.

###  2. Listing EKS Clusters
eksctl get cluster
aws eks update-kubeconfig --name eks-cluster 

### 3. Inspect Nodes
### Once your cluster is up and running, you will be able to see the nodes:
### These are managed nodes that run Amazon Linux applications on Amazon EC2 instances.

### You can now view the nodes of your cluster by running
kubectl get nodes -o custom-columns=Name:.metadata.name,nCPU:.status.capacity.cpu,Memory:.status.capacity.memory
kubectl get nodes -o wide
kubectl get nodes
kubectl get all --all-namespaces

### 4. You can also see the workloads running on your cluster.
kubectl get pods -A -o wide

### Describing an EKS Cluster
aws eks describe-cluster --name eks-cluster1

### Listing Node Groups
eksctl get nodegroup --cluster eks-cluster1

### Describing a Node Group
aws eks describe-nodegroup --cluster-name  eks-cluster1
aws eks describe-nodegroup --cluster-name my-eks-cluster --name my-node-group

### To delete cluster
eksctl delete cluster --name daves-cluster




### Core kubernetes concepts 
### Kubernetes controllers
First, here are some fundamentals of Controllers. The Kubernetes documentation uses the example that a controller is like your heat thermostat. The position of the dial is its desired state, the current temperature is its actual state, and the thermostat constantly applies or removes heat in an effort to keep the two in sync. This is how a Kubernetes controller works - it is a loop that watches the state of your cluster and makes changes as needed, always working to maintain your desired state. In Kubernetes, controllers of the control plane implement control loops that repeatedly compare the desired state of the cluster to its actual state. If the cluster's actual state doesn’t match the desired state, then the controller takes action to fix the problem. The Kubernetes controller keeps the current state of Kubernetes objects in sync with your declared desired state
Controllers can track many objects including:
What workloads are running and where
Resources available to those workloads
Policies around how the workloads behave (restart, upgrades, fault-tolerance)

## Different types of controllers
ReplicaSet - A ReplicaSet creates a stable set of pods, all running the same workload. You will almost never create this directly.
Deployment - A Deployment is the most common way to get your app on Kubernetes. It maintains a ReplicaSet with the desired configuration, with some additional configuration for managing updates and rollbacks.
StatefulSet - A StatefulSet is used to manage stateful applications with persistent storage. Pod names are persistent and are retained when rescheduled (app-0, app-1). Storage stays associated with replacement pods, and volumes persist when pods are deleted.
Job - A Job creates one or more short-lived Pods and expects them to successfully terminate.
CronJob - A CronJob creates Jobs on a schedule.
DaemonSet - A DaemonSet ensures that all (or some) Nodes run a copy of a Pod. As nodes are added to the cluster, Pods are added to them. As nodes are removed from the cluster, those Pods are garbage collected. Common for system processes like CNI, Monitor agents, proxies, etc.

### Kubernetes Operators 
A Kubernetes operator is an application-specific controller that extends the functionality of the Kubernetes API to create, configure, and manage instances of complex applications on behalf of a Kubernetes user. Operators are software extensions to Kubernetes that make use of custom resources to manage applications and their components. Operators follow Kubernetes principles, notably the control loop.

## Resources and custom resources in kubernetes 
what is a resource in kubernetes?: A resource is an endpoint in the Kubernetes API that stores a collection of API objects of a certain kind; for example, the built-in pods resource contains a collection of Pod objects.In simpler terms, a resource is a specific API URL used to access an object

### References 
https://devopscube.com/kubernetes-objects-resources/
https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
```