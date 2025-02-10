# Deploying a basic S3 static website using terraform
Deploying a basic S3 static website using terraform

You can use Amazon S3 to host a static website. On a static website, individual webpages include static content. They might also contain client-side scripts.

In this tutorial, the website will be accessed using S3 Bucket Endpoint which will have name of the bucket, we can hide it by creating a CNAME record in Route53 if you have a domain.

We can either use bucket policy (used in majority of cases), but we can use bucket ownership controls and bucket/object ACLs to define more granularity. (Code is commented in main.tf, all objects also need to use acl="public-read")

Architecture Diagram:

![alt text](/images/diagram.png)

Step 1: Create an S3 bucket with unique name and amend public access settings

Step 2: Create a resource policy for bucket and objects in it (or ownership controls with bucket/object ACLs)

Step 3: Upload files to the S3 bucket

Terraform Apply Output:
```
Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

static_site_endpoint = "http://my-s3-static-bucket-v1.s3-website-us-east-1.amazonaws.com"
```

S3 Bucket:

![alt text](/images/s3bucket.png)

Static Website Hosting Enabled:

![alt text](/images/s3static.png)

S3 Public Access Block

![alt text](/images/publicaccess.png)

S3 BucketPolicy

![alt text](/images/bucketpolicy.png)

Website:

![alt text](/images/website.png)

Terraform Destroy Output:
```
Destroy complete! Resources: 7 destroyed.
```

Resources:
https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html