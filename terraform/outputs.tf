output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "ALB DNS name for accessing the app"
  value       = module.ec2.alb_dns_name
}

output "github_actions_role_arn" {
  description = "Copy this into GitHub Secrets"
  value       = module.iam_oidc.role_arn
}

output "app_bucket_name" {
  description = "S3 bucket name for app storage"
  value       = module.s3.app_bucket_name
}
