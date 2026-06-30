terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {} # Values passed via backend.hcl at init

}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
}

module "ec2" {
  source            = "./modules/ec2"
  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  app_bucket_arn    = module.s3.app_bucket_arn
  app_bucket_name   = module.s3.app_bucket_name
  instance_type     = var.instance_type
  key_name          = var.key_name
}

module "s3" {
  source       = "./modules/s3"
  project_name = var.project_name
  environment  = var.environment
}

module "iam_oidc" {
  aws_region           = var.aws_region
  project_name         = var.project_name
  source               = "./modules/iam_oidc"
  github_org           = var.github_org
  github_repo          = var.github_repo
  environment          = var.environment
  aws_account_id       = var.aws_account_id
  create_oidc_provider = var.create_oidc_provider
  ec2_role_arn         = module.ec2.ec2_role_arn
}

