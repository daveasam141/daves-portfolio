# AWS Region
variable "region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "us-east-2"
}

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.small"
}

variable "ssh_key" {
  default = "demo.pem"
}

variable "key_name" {
  default = "demo"
}

variable "ssh_key_pair" {
  default = ""
  type    = string
}

variable "ssh_private_pair" {
  default = ""
  type    = string
}
