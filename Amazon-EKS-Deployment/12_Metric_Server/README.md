#### Install Metrics Server on EKS 

# 1. Deploy Metrics Server 
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
![alt text](<screenshots/Screenshot 2025-03-19 at 6.02.00 PM.png>)

# 2. Allows Metrics Servers to work with EKS
Since EKS uses self-managed Kubelets, you need to modify the deployment to allow insecure TLS communication with worker nodes.EKS worker nodes often have self-signed certificates that Metrics Server cannot verify.
kubectl edit deployment metrics-server -n kube-system
Find the args: section and add the following flags
containers:
  - args:
      - --kubelet-insecure-tls
      - --kubelet-preferred-address-types=InternalIP
![alt text](<Screenshot 2025-03-19 at 6.23.40 PM.png>)
# Explanation of Added Arguments 
--kubelet-insecure-tls
Allows Metrics Server to ignore self-signed TLS certificates on worker nodes (Kubelets).
--kubelet-preferred-address-types=InternalIP
Forces Metrics Server to connect to worker nodes using their Internal IPs instead of their Hostnames.

3. Restart Metrics Server 
kubectl rollout restart deployment metrics-server -n kube-system
![alt text](<screenshots/Screenshot 2025-03-19 at 6.30.58 PM.png>)
![alt text](<screenshots/Screenshot 2025-03-19 at 6.34.22 PM.png>)

4. Verify the Metrics API
kubectl get apiservices | grep metrics
![alt text](<Screenshot 2025-03-19 at 6.37.11 PM.png>)

### Test metrics scraper 
k top pods
![alt text](<screenshots/Screenshot 2025-03-19 at 6.45.54 PM.png>)