### Cost Optimization While Managing Your EKS Cluster

### Autoscaling EKS Nodes
Optimizing AWS Costs: Scaling Up and Down

### Scaling Down EKS Cluster When Not in Use

1. Sign in to your AWS account.
2. Go to EC2.
3. Navigate to Auto Scaling Groups.
4. Choose your EKS auto-scaling group.
5. Edit and scale down to 0 instances.

### Scaling Up EKS Cluster When Needed

1. Sign in to your AWS account.
2. Go to EC2.
3. Navigate to Auto Scaling Groups.
4. Choose your EKS auto-scaling group.
5. Edit and scale up to desired state (e.g., 2 or 3 instances).

![autoscaling](image.png)

### Assignment: Lambda Function for Nightly Scaling Down of EKS Cluster