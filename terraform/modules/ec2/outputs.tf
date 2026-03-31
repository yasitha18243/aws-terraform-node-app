output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "instance_ids" {
  value = aws_instance.app[*].id
}

output "instance_azs" {
  value = aws_instance.app[*].availability_zone
}
