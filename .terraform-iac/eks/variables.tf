variable "app" {
  description = "App name"
}

variable "vpc_id" {
  description = "VPC Id"
}

variable "public_nets" {
  description = "List of IDs of public subnets"
}

variable "instance_types" {
  description = "instance type for EKS worker"
}

variable "ami_type" {
  description = "AMI type"
}

variable "account_id" {
  description = "AWS Account ID"
}

variable "namespace" {
  type        = list(string)
  description = "Namespace applicatif et infra"
}

variable "iam_list" {
  type        = list(string)
  description = "list of IAM user"
}

variable "cluster_issuer_email" {
  description = "email for letsencrypt"
}