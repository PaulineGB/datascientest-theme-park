terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

backend "s3" {
  bucket =  "mytprformback"
  key = "tpriacstate/terraform.tfstate"
  region = var.aws_region
  dynamodb_table = "terraform_remote_state_lock"
}
