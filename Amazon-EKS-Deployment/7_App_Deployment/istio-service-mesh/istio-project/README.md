###### “Securing and Managing Microservices with Istio in Kubernetes”

## Step 1: Set Up Kubernetes & Install Istio If not already installed.(using eks in this case)
#### Deploying Istio Service Mesh on eks 
# 1: Install istio
curl -L https://istio.io/downloadIstio | sh -
cd istio-*
export PATH=$PWD/bin:$PATH

# 2. Install istio inside the cluster
istioctl install --set profile=demo -y
# Verify installation
k get pods -n istio-system
![alt text](<screenshots/Screenshot 2025-03-23 at 6.28.34 PM.png>)

# 3. Label default namespace for istio auto-injection
kubectl label namespace default istio-injection=enabled
kubectl get namespace default --show-labels
![alt text](<screenshots/Screenshot 2025-03-23 at 6.36.59 PM.png>)


## Step 2: Deploy a Sample Microservices App
Deploy the Online Bookstore App (or any microservices app with multiple services).
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
![alt text](<../Screenshot 2025-03-23 at 6.47.33 PM.png>)


## Step 3: Enable mTLS for Service-to-Service Security
vi peer-authentication.yaml
k apply -f peer-authentication.yaml
![alt text](<screenshots/Screenshot 2025-03-23 at 7.17.18 PM.png>)


### Step 4: Set Up Traffic Management (Canary, A/B, Blue-Green Deployments)
Define a VirtualService and DestinationRule to split traffic:
vi traffic-management.yaml
k apply -f  traffic-management.yaml
![alt text](<screenshots/Screenshot 2025-03-23 at 7.32.59 PM.png>)


### Step 5: Secure the API with JWT Authentication
Create a JWT Policy for authentication:
vi jwt-auth.yaml
k apply -f jwt-auth.yaml
![alt text](<screenshots/Screenshot 2025-03-23 at 8.35.16 PM.png>)


### Step 6: Monitor & Observe Istio Service Mesh
1.	Deploy Kiali for Service Graph Visualization
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/addons/kiali.yaml
istioctl dashboard kiali
![alt text](<screenshots/Screenshot 2025-03-23 at 8.42.43 PM.png>)

2.	Enable Distributed Tracing with Jaeger(for observablity and troubleshooting microservice based apps)
#When Jaeger is integrated with Istio, Istio automatically injects sidecar proxies (Envoy) into each service pod. These proxies collect trace data about requests coming in and out of the services. The sidecars 
 Key Terms
	•	Distributed Tracing: The practice of tracking the flow of a request across different microservices.
	•	Sidecar Proxy (Envoy): In Istio, sidecars are deployed alongside each service and intercept requests, collecting trace data and forwarding it to Jaeger.
	•	Trace: A trace represents a request as it travels through the service mesh. It includes information like timing and service interactions.
	•	Span: A span is a single unit of work in a trace, such as a single HTTP request.forward this data to Jaeger for visualization and analysis.
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.25/samples/addons/jaeger.yaml
![alt text](<Screenshot 2025-03-23 at 10.33.04 PM.png>)

3.	Set Up Prometheus & Grafana for Metrics
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.25/samples/addons/prometheus.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.25/samples/addons/grafana.yaml
![alt text](<screenshots/Screenshot 2025-03-23 at 10.21.09 PM.png>)
![alt text](<screenshots/Screenshot 2025-03-23 at 10.26.52 PM.png>)








