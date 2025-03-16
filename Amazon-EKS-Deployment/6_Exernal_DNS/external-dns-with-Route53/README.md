### INGRESS CONTROLLER AND EXTERNAL DNS WITH ROUTE53 ON EKS

Utilizing Ingress resources is a fantastic method for making Kubernetes Applications accessible to the outside world. With EKS, the need to create a Load Balancer for each application exposure is avoided. Additionally, K8S Ingress provides a single entry point to the cluster. This consolidation not only saves costs by managing and monitoring a single Load Balancer but also reduces the cluster's attack surface. This is great, however, every time we need to expose an application we will need to create and manage DNS records manually. We can set externalDNS by adding a simple annotation to our ingress resources pointing to the DNS record and then it will be created automatically on Route53. In summary, the combination of Ingress resources and ExternalDNS streamlines operations, saves resources, and enhances security.

### YOU LEARN HOW TO:

- Installing Nginx Ingress controller
- Setting Domain and TLS certificate
- Configuring the external DNS
- Testing DNS creation on Route53
- Debugging External DNS and Route53
- Testing Ingress resource and External DNS

```sh
### Prereq we need:
1.	Purchase the domain or delegate the zone on Route 53. (Optional)
2.	Request a certificate using AWS Certificate Manager. (Optional)
3.	Create records in Route 53 to validate the certificate.
4.	Deploy the nginx-ingress controller and check the load balancer.
5.	Deploy your applications.
6.	Deploy the ingress class and rules.
```

![image1](image1.png)
![image2](image2.png)
![image3](image3.png)

```sh
### Check the zone:
### 1. Installing external DNS services
aws sts get-caller-identity --query Account --output text
aws route53 list-hosted-zones-by-name --output json --dns-name "2waveyyy.com" | jq -r '.HostedZones[0].Id'

(Optional)
### Check the certificate:
aws acm list-certificates

### The next steps are two:
1. Configuring the permissions to give access to Route53
2. Deploying the External DNS
3. Configuring the permissions to give access to Route53

## Create/Associate IAM OIDC provider with the cluster
eksctl utils associate-iam-oidc-provider  --cluster=eks-cluster1 --approve 

### Create an IAM role for the service account
1. Redirect all sub-domain to this particular domain to my ALB 
2. Enable the **Alias** 
3. Select  Application Loadbalancer
4. Create Record
5. Test by creating app with ingress rule

![image5](image5.png)

```sh


### Using external DNS providers with Route53 & EKS
aws route53 list-hosted-zones-by-name --output json --dns-name "example.com." | jq -r '.HostedZones[0].Id'

kubectl  create ns external-dns
kubectl apply -f route53-external-dns.yaml -n=external-dns
kubectl get deployments -n=external-dns
kubectl get po -n external-dns  

```
