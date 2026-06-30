variable "github_org" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_account_id" {
  type = string
}

variable "create_oidc_provider" {
  type    = bool
  default = true
}

variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}


variable "ec2_role_arn" {
  type        = string
  description = "ARN of the EC2 instance role, for PassRole permission"
}
