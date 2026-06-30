variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "github_org" {
  description = "Github organization or username"
  type        = string
}

variable "github_repo" {
  description = "Github respository name"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "create_oidc_provider" {
  description = "Github respository name"
  type        = bool
  default     = true
}

variable "key_name" {
  type        = string
  description = "Name of the existing EC2 key pair to use for SSH access"
}
