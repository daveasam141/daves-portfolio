```sh 
# trivy
Trivy’s Scanning Capabilities Encompass:
1. Container Images
2. Filesystems
3. Remote Git Repositories
4. Virtual Machine Images
5. Kubernetes
6. AWS Environments

These scanners are adept at Identifying:
1. In-use OS packages and software dependencies (Software Bill of Materials — SBOM)
2. Known vulnerabilities (CVEs — Common Vulnerabilities and Exposures)
3. Infrastructure as Code (IaC) issues and misconfigurations
4. Uncovering sensitive information and hidden secrets
5. Assessing software licenses

### Installing Trivy CLI 
brew install aquasecurity/trivy/trivy

### To verify that Trivy is installed 
trivy version (This should return an output)

### To see trivy commands 
trivy --help

### To ask trivy to generate a report on a namespace (This command runs tests on all nodes in the default namespace and displays a summary report)
trivy k8s --include-namespaces default --report summary 

### To generate a full report
trivy k8s --include-namespaces ingress-nginx --report=all

### To display the report for only urgent vulnerabilities 
 trivy k8s --include-namespaces ingress-nginx --report=all --severity MEDIUM,HIGH,CRITICAL

### To display a summary report for a specific deployment
 trivy k8s --include-namespaces kube-system --report=summary deployment/coredns

### To generate and save a report locally  for a namespace (find out syntax for all namespaces) 
trivy k8s --include-namespaces cert-manager --report=summary  -o trivy-report.txt

### Installing trivy Kubernetes Operator 
This Kubernetes Operator continuously scans your Kubernetes cluster for security issues, and generates security reports as Kubernetes Custom Resources. It watches Kubernetes for state changes and automatically triggers scans in response to changes, for example initiating a vulnerability scan when a new Pod is created.

### Installing Trivy using a helm chart 
helm repo add aqua https://aquasecurity.github.io/helm-charts/
helm repo update
helm install trivy-operator aqua/trivy-operator \
   --namespace trivy-system \
   --create-namespace \
   --set="trivy.ignoreUnfixed=true"
The above command will install the latest version of trivy and create a new namespace and configure it to scan all namespaces except kube-system and trivy-system 

### To inspect created vulnerability reports in all namespaces 
kubectl get vulnerabilityreports --all-namespaces -o wide

### To inspect created configauditreports 
kubectl get configauditreports --all-namespaces -o wide

### To inspect the work log of trivy-operator 
kubectl logs -n trivy-system deployment/trivy-operator 

### Installing Lens extension for trivy-operator 
First download the tarball file for the lens extension from https://github.com/aquasecurity/trivy-operator-lens-extension/releases
https://github.com/aquasecurity/trivy-operator-lens-extension?tab=readme-ov-file

### References 
https://help.ovhcloud.com/csm/en-public-cloud-kubernetes-install-trivy?id=kb_article_view&sysparm_article=KB0049874
https://github.com/aquasecurity/trivy-operator-lens-extension?tab=readme-ov-file





```

