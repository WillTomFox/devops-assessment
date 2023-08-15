# AWS access key for personal account
variable "access_key" {
  type = string
}

# AWS secret key for personal account
variable "secret_key" {
  type = string
}

# AWS account ID for TP account
variable "aws_account_id" {
  type = string
}

# AWS region
variable "region" {
  type = string
}

# VPC ID
variable "vpc_id" {
  type = string
}

# CIDR block
variable "cidr_block" {
  type = string
}