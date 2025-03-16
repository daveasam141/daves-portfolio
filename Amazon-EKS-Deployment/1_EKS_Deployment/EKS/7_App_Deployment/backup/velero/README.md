### VELERO

##############################################
######## Installing velero part2
### VELERO
Velero is an open-source solution from VMware. These tools provide an easy and efficient way to backup and restore Kubernetes resources and data. Kubernetes backup can be performed at the cluster level, namespace level, or even at the resource level.
Velero is an open-source tool that enables backup and disaster recovery of Kubernetes clusters and their persistent volumes. It can be used to back up the Kubernetes resources, including namespace, deployment, stateful set, cronjob, and others, as well as the persistent volumes associated with them.
Velero consists of two components:
A Velero server pod that runs in the Amazon EKS cluster
A command-line client (Velero CLI) that runs locally
When you run Velero backup create test-backup:
The Velero client makes a call to the Kubernetes API server to create a Backup object.
The Backup Controller notices the new Backup object and performs validation.
The BackupController begins the backup process. It collects the data to back up by querying the API server for resources.
The Backup Controller makes a call to the object storage service — like, AWS S3 — to upload the backup file.

### OIDC provoder and URL
IAM OIDC, or OpenID Connect, which allows the cluster to authenticate AWS API requests and obtain new JSON Web Tokens (JWT) for each pod that is using the service account.
Although by default every EKS cluster has an OIDC issuer URL associated with it, the IAM OIDC provider for that issuer is not created automatically. Run the following commands to create the IAM OIDC provider if it does not exist: 
### To check the IAM OIDC provider of an eks cluster 
aws eks describe-cluster --name (cluster-name) --query "cluster.identity.oidc.issuer" --output text (replace name of cluster)
output:https://oidc.eks.us-east-2.amazonaws.com/id/2195FB43FC4133E84942AEB1FA305612
aws iam list-open-id-connect-providers | grep 2195FB43FC4133E84942AEB1FA305612 (replace the id # with the output from the line above)

### To create IAM OIDC provider
eksctl utils associate-iam-oidc-provider --cluster eks-cluster-1 --approve (change cluster name to your cluster)

### Create s3 bucket to restore velero backups 
aws s3api create-bucket --bucket vbucket-2 --region us-east-2 (this command might not work for us-east-2, if not try the line below) 
aws s3 mb s3://test-2-v --region us-east-2 

### Create an IAM role to give access to Velero backups
Create a policy with permissions to take Velero backups and access the S3 bucket that we just created:
cat > velero-policy.json <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeVolumes",
                "ec2:DescribeSnapshots",
                "ec2:CreateTags",
                "ec2:CreateVolume",
                "ec2:CreateSnapshot",
                "ec2:DeleteSnapshot"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:PutObject",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts"
            ],
            "Resource": [
                "arn:aws:s3:::${BUCKET}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::${BUCKET}" 
            ]
        }
    ]
}
EOF

(Change ${BUCKET} to the name of the bucket you created)

### Create a trust relationship policy document to allow Velero pods to assume the role that we will create in the next step: 
cat > velero-trust-policy.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::440706784567:oidc-provider/https://oidc.eks.us-east-2.amazonaws.com/id/2195FB43FC4133E84942AEB1FA300351"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "https://oidc.eks.us-east-2.amazonaws.com/id/2195FB43FC4133E84942AEB1FA305612:aud": "sts.amazonaws.com",
          "https://oidc.eks.us-east-2.amazonaws.com/id/2195FB43FC4133E84942AEB1FA305612:sub": "system:serviceaccount:velero:velero"
        }
      }
    }
  ]
}
EOF

(Change the oidc url https://oidc.eks.us-east-2.amazonaws.com/id/2195FB43FC4133E84942AEB1FA305612 )
(Change the service acoount name if you want serviceaccount:velero but you can keep it as is )
(Also change iam::(put your aws account #))

### create the role and attach the trust relationship policy document: (make sure the policy and trust policy documents are in your curent directory when you run this command)
aws iam create-role --role-name VELERO_ROLE --assume-role-policy-document file://./velero-trust-policy.json
aws iam put-role-policy --role-name VELERO_ROLE --policy-name "velero-trust-policy" --policy-document file://./velero-policy.json

### To get aws account id 
aws sts get-caller-identity

### Download velero with brew 
brew install velero 

#### Installing Velero (make sure to chnage the bucket name to yours)
velero install --provider aws --plugins velero/velero-plugin-for-aws:v1.0.0 --bucket test-2-v --secret-file ~/.aws/credentials --backup-location-config region=us-east-2 --snapshot-location-config region=us-east-2 --use-node-agent

### Check get pods 
k get po -n velero

During the installation, a service account called Velero is created and annotated with the ARN of the IAM role. This service account is used by the Velero pod. EKS then injects environment variables AWS_ROLE_ARN and AWS_WEB_IDENTITY_TOKEN_FILE into the pod. 

### Check service account created by velero (change pod name:velero-96498cd8d-jr9zw to yours to run this command )
kubectl -n velero get pod velero-96498cd8d-jr9zw -o jsonpath='{range .spec.containers[0].env[*]}{.name}{"\n"}{end}'

### Configure backups to bucket (might already be done, run line 132 before you try this, if you already have one listed there's no need to run this) 
velero backup-location create test-2-v \
--provider aws \
--bucket test-2-v  \
--config region=us-east-2,s3ForcePathStyle="true" \
--default\

### To check backup storage location 
velero backup-location get

### To delete backup storage location (You don't need to run this, this is just to have in case you need it)
velero backup-location delete (name)

### To check logs 
k logs velero-555f59d484-6bfq7 -n velero --all-containers=true

### To run a test backup with velero 
 velero backup create test-backup

### To check backup
velero backup get (backupname)
velero backup get test-backup

### To describe or check the logs of a backup
velero backup describe test-backup
velero backup logs test-backup

### To check the aws bucket for new objects 
aws s3api list-objects --bucket test-2-v

### Create an nginx pod to backup and restore (you would have to refer to the nginx repo to deploy this pod, after you've deployed it, verify that everything is working correctly and continue from line 156)
### Check pods for nginx deployment 
k get po -n default

### Create a backup for nginx pod (you can change the name for the backup)
velero backup create nginx-backup1

### get nginx backup 
velero backup get nginx-backup1

### To check s3 bucket for bucket 
aws s3 ls test-2-v/backups/nginx-backup1/

### To restore backup for nginx pods 
velero restore create nginx-restore \
    --from-backup nginx-backup1 \
    --include-namespaces default

### To check the status of the restore
velero restore describe nginx-restore

### To uninstall velero
velero uninstall

### To add a file to path in zsh
vi ~/.zshrc
“export PATH=<newpath>
https://www.geeksforgeeks.org/add-a-directory-to-path-in-zsh/

### References 
https://cloudcasa.io/blog/how-to-setup-velero-backups-on-eks-using-iam-roles-for-service-accounts-irsa/
https://cloudcasa.io/blog/how-to-setup-velero-backups-on-eks-using-iam-roles-for-service-accounts-irsa/

