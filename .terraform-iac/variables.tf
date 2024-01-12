variable "aws_region" {
  type        = string
  description = "Region AWS"
  default     = "eu-west-3"
}

variable "app" {
  type        = string
  description = "App name"
  default     = "tpr"
}

variable "namespace" {
  type        = list(string)
  description = "Namespace applicatif et infra"
  default     = ["prod", "dev"]
}

variable "db_name" {
  type        = string
  description = "DB name"
  default     = "themeparkride"
}
variable "db_username" {
  type        = string
  description = "DB username"
  default     = "admin"
}

variable "db_password" {
  type        = string
  description = "DB password"
  sensitive   = true
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  type        = list(string)
  description = "Private subnets"
  default     = ["10.0.128.0/18", "10.0.192.0/18"]
}

variable "public_subnets" {
  type        = list(string)
  description = "Public subnets"
  default     = ["10.0.0.0/18", "10.0.64.0/18"]
}

variable "instance_types" {
  type        = string
  description = "instance type for EKS worker"
  default     = "t2.small"
}

variable "ami_type" {
  type        = string
  description = "AMI type"
  default     = "AL2_x86_64"
}

variable "account_id" {
  type        = string
  description = "AWS Account ID"
  sensitive   = true
}

variable "iam_list" {
  type        = list(string)
  description = "list of IAM user"
  default     = ["chris", "guillaume", "pauline", "github_deploy"]
}

variable "cluster_issuer_email" {
  type        = string
  default     = "nom@mail.com"
  description = "email for letsencrypt"
}
