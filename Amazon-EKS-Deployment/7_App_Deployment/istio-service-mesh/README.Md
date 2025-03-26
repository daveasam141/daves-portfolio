#### Deploying Istio Service Mesh on eks 
## Step 1: Install istio
curl -L https://istio.io/downloadIstio | sh -
cd istio-*
export PATH=$PWD/bin:$PATH

## 2. Install istio inside the cluster
istioctl install --set profile=demo -y
# Verify installation
k get pods -n istio-system

### 3. Enable automatic sidecar injecttion 
kubectl label namespace default istio-injection=enabled  ### you can change the ns that you would like to deploy microservices 

# Deploy a sample app
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/bookinfo/platform/kube/bookinfo.yaml
![alt text](<Screenshot 2025-03-23 at 6.47.33 PM.png>)

# Check if sidecar proxies (envoy ) are injected 
kubectl get pods


### Step 3: Expose the Application with Istio Gateway
# Deploy the Istio Ingress Gateway
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/bookinfo/networking/bookinfo-gateway.yaml

# 	Get the external IP of the Istio Ingress Gateway
kubectl get svc istio-ingressgateway -n istio-system

# Install Kiali (UI for Istio monitoring)
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/addons/kiali.yaml
![alt text](<screenshots/Screenshot 2025-03-23 at 6.10.03 PM.png>)


