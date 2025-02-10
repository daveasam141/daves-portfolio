variable "aws_region" {
  type        = string
  description = "AWS region to use for resources."
  default     = "us-east-2"
}


variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "emagetech"
}

variable "project" {
  type        = string
  description = "Project name for resource tagging"
  default     = "project"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all resources."
  default     = "demo"
}

variable "environment" {
  type        = string
  description = "Environment for deployment"
  default     = "dev"
}

variable "zone_id" {
  type        = string
  description = "Name of the domain"
  default     = "Z0047307TEM3QG88JQER"
}
variable "bucket_name" {
  type        = string
  description = "Name of the bucket."
  default     = "dave-website2"
}
