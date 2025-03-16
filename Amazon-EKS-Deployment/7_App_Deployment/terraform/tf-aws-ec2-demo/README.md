

####################################################

DevOps Project (CI/CD Jenkins pipeline for kubernetes)
Create slack channel 
Create slack notification

### Create a key pair

```sh
aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text > MyKeyPair.pem
chmod 400 MyKeyPair.pem
aws ec2 delete-key-pair --key-name MyKeyPair
```

### aws-key-pair-find-delete.sh

```sh
aws ec2 describe-key-pairs --query 'KeyPairs[*].KeyName' --output table

# Find instances that uses a key pair you found out above
aws ec2 describe-instances --filters Name=instance-state-name,Values=running Name=key-name,Values="KP-NAME" --query 'Reservations[*].Instances[*].InstanceId'

# If you get an empty response, you can opt to delete it with:
aws ec2 delete-key-pair --key-name KP-NAME

### To view local public key 
cat ~/.ssh/id_rsa.pub 

### Terraform commands 
terraform init
terraform fmt 
terraform validate 
terraform plan 
terraform apply -auto-approve

### To delete terraform deployment
terraform destroy -auto-approve





```
