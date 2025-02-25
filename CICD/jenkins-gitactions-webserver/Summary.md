What you will learn: 

### Table of Content
 1.⁠ ⁠Introduction 
 2.⁠ ⁠Launch EC2 instance and Install Jenkins using Terraform 
 3.⁠ ⁠Configure Jenkins 
 4.⁠ ⁠Create GitHub repository 
 5. Write Terraform code 
 6.⁠ ⁠Create docker project 
 7.⁠ ⁠Create and Run Jenkins Pipeline 
 8 .⁠ ⁠Summary 

**Step 1**. Introduction 

In this module, we'll be launching an EC2 instance, install Apache Web (httpd) and create a simple website using Jenkins Pipeline. 

**Step 2**. Use terraform to automate: 
 1.⁠ ⁠Create a Key pair 
 2.⁠ ⁠Create a Security Group
 3.⁠ ⁠Create an EC2 instance
 4.⁠ ⁠Install and Configure Jenkins

**Step 3**. Configure Jenkins 
 1.⁠ ⁠Install required  Jenkins plugins 
 2.⁠ ⁠Integrate Jenkins with AWS

**Step 4**. Write Terraform code 
 1.⁠ ⁠Create & clone GitHub repository 
 2.⁠ ⁠Configure Webhook  

**Step 5**. Write Terraform code: 
 1.⁠ Develop Terraform module for launching EC2 Instance 
 2.⁠ Write shell script to install Apache web in the Instance launched with Terraform 
 3. Test Run the code locally

**Step 6**. Create Jenkinsfile  
1.⁠ ⁠Create Jenkinsfile 
2.⁠ ⁠Checkin/Push your code to GitHub 

**Step 7**. Create & Run Jenkins Pipeline 
1. Create Jenkins Pipeline
2. Integrate Jenkins with GitHub repository 
3. Run the Pipeline
4. Monitor the Pipeline stages
5. Verify that the Pipeline deployed successfully and your app is working

**Summary**

We Automate Static Website Deployment with CI/CD Pipeline to build and run a web application hosted on Linux Instance. 

**⁠DevOps Tools Used**  
- Linux: Used for coding. 
- Terraform: To Automate the launching oof EC2 Linux Instance 
- GitHub: To share code files, upload files, create coding projects and collaborate with fellow developers. 
- Jenkins: To create the build pipeline.
- AWS EC2: To run Apache Web server.

### We created  Jenkinsfile with multiple stages as shown below:

1. Init stage - The `terraform init` command initializes a working directory containing configuration files and installs plugins, initilize the backend, install providers, and download modules required for the provider. 

2. Plan stage - The `terraform plan` command creates an execution plan, which lets you ppreview the changes Terraform will make to your infrastructure before you apply them. 

3. Apply stage - The `terraform apply` command makes the changes defined by your plan to create or update resources.

4. Destroy stage - The `terraform destroy` command terminates resources managed by your Terraform project. 

```sh
terraform init 
terraform fmt
terraform validate 
terraform plan 
terraform apply -auto-approve  
terraform destroy -auto-approve
```
