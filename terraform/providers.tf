# AWS provider

provider "aws" {
  region = "eu-west-2"
  access_key = var.access_key # TP account access key
  secret_key = var.secret_key # TP account access secret
}

terraform {
  required_providers {
    aws = {
      source     = "hashicorp/aws"
      version    = ">= 4.0.0"
    }
  }
  # Use S3 for tfstate - configured in workflow 
  backend "s3" {
  }
}