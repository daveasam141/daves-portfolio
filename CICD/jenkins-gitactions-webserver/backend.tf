terraform {
  backend "s3" {
    bucket         = "s3-remote-backend-20240602203434304200000001"
    key            = "terra-backend/terraform.tfstate"
    encrypt        = true
    region         = "us-east-2"
    dynamodb_table = "terraform-state-lock-dynamo5"
  }
}