###### Setting up a local cluster using kubeadm
### Pre req
Linux server running either redhat or debian based distro with at least 2cpu and 4GB of RAM ( in this case, we are using rhel 9)
One master node: k8s-master
at least one worker node, in this case i have 2: k8s-worker-one k8s-worker-2

### Install Kubeadm 
## Pre-req: 
Ensure that the followiiing ports are open: 
Control Plane 
Protoco  Direction	Port Range	Purpose	                Used By
TCP	     Inbound	6443	    Kubernetes API server	All
TCP	     Inbound	2379-2380	etcd server client API	kube-apiserver, etcd
TCP	     Inbound	10250	    Kubelet API	                Self, Control plane
TCP	     Inbound	10259	    kube-scheduler	            Self
TCP	     Inbound	10257	    kube-controller-manager	    Self

Worker nodes
Protocol	Direction	Port Range	     Purpose	           Used By
TCP	        Inbound	    10250	         Kubelet API	       Self, Control plane
TCP       	Inbound	    10256	         kube-proxy	           Self, Load balancers
TCP	        Inbound	    30000-32767	     NodePort Services†    All


## Step 1: On the control plane, open ports:
sudo firewall-cmd --permanent --add-port={6443,2379,10250,10259,10257}/tcp
sudo firewall-cmd --reload

## Step 2: Disable swap (won't survive reboot)
sudo swapoff -a 
comment out swap line in /etc/fstab 

## Step 3: Set SELINUX to permissive mode (it could have some settings that could mess with the kubelet configuration)
setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config 
sestatus ### Check SElinux status to make sure its in permissive mode

## Step 4: Add Kernel Modules and Parameters 
###Adding kernel modules and parameters is crucial for Kubernetes to manage network traffic and container communication across nodes. The overlay module facilitates layered filesystems for efficient storage in containers, while br_netfilter allows network filtering between bridged interfaces. These modules ensure proper inter-pod networking and adherence to Kubernetes’ network policies, preventing performance issues and enhancing functionality.###

sudo echo -e "overlay\nbr_netfilter" | sudo tee /etc/modules-load.d/containerd.conf && sudo modprobe overlay && sudo modprobe br_netfilter 

###Kubernetes requires specific kernel parameters for effective network traffic management:
net.bridge.bridge-nf-call-iptables = 1 enables bridged traffic to pass through iptables, crucial for routing between nodes and pods.
net.ipv4.ip_forward = 1 allows IP forwarding for pod-to-pod communication across node interfaces.
net.bridge.bridge-nf-call-ip6tables = 1 manages IPv6 traffic on bridged interfaces through ip6tables, important for IPv6 networking environments.###

sudo echo -e "net.bridge.bridge-nf-call-iptables = 1\nnet.ipv4.ip_forward = 1\nnet.bridge.bridge-nf-call-ip6tables = 1" | sudo tee -a /etc/sysctl.d/k8s.conf

###Add parameters by:
sudo sysctl --system

### Step 5: Install container runtime (containerd)
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install containerd.io -y
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

## Restart and enable containerd runtime 
sudo systemctl restart containerd
sudo systemctl enable containerd


### Step 6: Install kubernetes tools
# add the kubernetes yum repository The exclude parameter in the repository definition ensures that the packages related to Kubernetes are not upgraded upon running yum update: 
# This overwrites any existing configuration in /etc/yum.repos.d/kubernetes.repo
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.32/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.32/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF
# Install kubelet, kubeadm and kubectl 
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
sudo systemctl enable --now kubelet

*** Make sure you have consistent cgroup drivers with container runtime and kubelet. To interface with control groups, the kubelet and the container runtime need to use a cgroup driver. It's critical that the kubelet and the container runtime use the same cgroup driver and are configured the same.

### Step 7: Initialize control plane 
sudo kubeadm init ### make sure to store output to configure worker nodes


###### Woker nodes config 
## Step 1: On the control plane, open ports:
sudo firewall-cmd --permanent --add-port={10250,10256,30000-32767}/tcp
sudo firewall-cmd --reload

## Step 2: Disable swap (won't survive reboot)
sudo swapoff -a 

## Step 3: Set SELINUX to permissive mode (it could have some settings that could mess with the kubelet configuration)
setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config 
sestatus ### Check SElinux status to make sure its in permissive mode

## Step 4: Add Kernel Modules and Parameters 
###Adding kernel modules and parameters is crucial for Kubernetes to manage network traffic and container communication across nodes. The overlay module facilitates layered filesystems for efficient storage in containers, while br_netfilter allows network filtering between bridged interfaces. These modules ensure proper inter-pod networking and adherence to Kubernetes’ network policies, preventing performance issues and enhancing functionality.

sudo echo -e "overlay\nbr_netfilter" | sudo tee /etc/modules-load.d/containerd.conf && sudo modprobe overlay && sudo modprobe br_netfilter 

###Kubernetes requires specific kernel parameters for effective network traffic management:
net.bridge.bridge-nf-call-iptables = 1 enables bridged traffic to pass through iptables, crucial for routing between nodes and pods.
net.ipv4.ip_forward = 1 allows IP forwarding for pod-to-pod communication across node interfaces.
net.bridge.bridge-nf-call-ip6tables = 1 manages IPv6 traffic on bridged interfaces through ip6tables, important for IPv6 networking environments.###

sudo echo -e "net.bridge.bridge-nf-call-iptables = 1\nnet.ipv4.ip_forward = 1\nnet.bridge.bridge-nf-call-ip6tables = 1" | sudo tee -a /etc/sysctl.d/k8s.conf

###Add parameters by:
sudo sysctl --system

### Step 5: Install container runtime (containerd)
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install containerd.io -y
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml ### using systemd C group drivers 

## Restart and enable containerd runtime 
sudo systemctl restart containerd
sudo systemctl enable containerd


### Step 6: Install kubernetes tools
# add the kubernetes yum repository The exclude parameter in the repository definition ensures that the packages related to Kubernetes are not upgraded upon running yum update: 
# This overwrites any existing configuration in /etc/yum.repos.d/kubernetes.repo
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.32/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.32/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF
# Install kubelet, kubeadm and kubectl 
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
sudo systemctl enable --now kubelet

### Step 7:add the worker node to the cluster
# on the control plane run:
kubeadm token create --print-join-command
# The command above will print an output like this:
kubeadm join <control-plane-ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
![alt text](<screenshot/Screenshot 2025-03-05 at 11.54.53 PM.png>)
# make sure all nodes have been successfully joined to the cluster (nodes might not be in ready state until the cni network plugin has been installed)
k get nodes 
![alt text](<screenshots/Screenshot 2025-03-12 at 11.06.51 AM.png>)
# Label node 
kubectl label node worker-node-2 node-role.kubernetes.io/worker=""
kubectl label node worker-01 node-role.kubernetes.io/worker=""


#### Step 8 Install a network plugin, this allows pods to communicate with each other(CNI, using calico in this case) 
# Apply the Calico YAML file to deploy the required components:
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26/manifests/calico.yaml
# Verify installation
kubectl get pods -n kube-system | grep calico
![alt text](<screenshots/Screenshot 2025-03-12 at 11.15.35 AM.png>)

 
 
 
 
 
