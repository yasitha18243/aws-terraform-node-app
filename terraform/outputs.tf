output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "ALB DNS name for accessing the app"
  value       = module.ec2.alb_dns_name
}
