###### Installing MetalLB on Kubeadm cluster
### Step 1: Install MetalLB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/main/config/manifests/metallb-native.yaml
![alt text](<screenshots/Screenshot 2025-03-13 at 11.45.42 PM.png>)
### 1.2 Check MetalLB pods
kubectl get pods -n metallb-system
![alt text](<screenshots/Screenshot 2025-03-13 at 11.49.31 PM.png>)

### Step 2: Configure MetalLB with an IP Address Pool
MetalLB requires a pool of IPs that it can assign to services of type LoadBalancer.

apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: my-ip-pool
  namespace: metallb-system
spec:
  addresses:
  - 10.0.0.230-10.0.0.249   # Adjust this range to match your network

---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: my-l2-advert
  namespace: metallb-system

# Apply config 
kubectl apply -f metallb-config.yaml