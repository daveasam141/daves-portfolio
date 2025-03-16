### Storage Class

Kubernetes StorageClass

Kubernetes storage classes provide a way to dynamically provision persistent storage for applications running on a Kubernetes cluster. By using storage classes, you can create and attach storage volumes to your applications on-demand, without having to manually provide and manage the underlying storage infrastructure.



```sh
### Installing  EBS  storage classe
helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver/
helm repo update

# Deploy EBS CSI Driver
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=master"

# Verify ebs-csi pods running
kubectl get pods -n kube-system

kubectl apply -f gp3.yaml 
kubectl get pods -n kube-system | grep ebs-csi

kubectl annotate storageclass ebs-gp3 storageclass.kubernetes.io/is-default-class=true --overwrite
kubectl annotate storageclass gp2 storageclass.kubernetes.io/is-default-class=false --overwrite
kubectl get storageclass
```

### Learn more about StorageClass

- What is Kubernetes StorageClass?
- Why Use Kubernetes Storage Classes?
- Kubernetes StorageClass Concepts
- Kubernetes StorageClass Common Operations [with Examples]
- List Storage Classes in Kubernetes
- How to Create Storage Classes in Kubernetes
- How do StorageClasses help to make data persistence more dynamic?
