terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # State storage in AWS
  backend "s3" {
    bucket       = "node-app-terraform-state-2026"
    key          = "dev/terraform.tfstate"
    region       = "ap-southeast-2"
    use_lockfile = true
  }
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
}

module "s3" {
  source       = "./modules/s3"
  project_name = var.project_name
}

