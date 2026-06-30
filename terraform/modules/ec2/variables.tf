variable "project_name" {}
variable "environment" {}
variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "app_bucket_arn" {}
variable "app_bucket_name" {}
variable "instance_type" {}
variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH into EC2 instances"
  type        = string
  default     = "103.53.117.233/32"
}
variable "key_name" {
  type        = string
  description = "Name of the existing EC2 key pair to use for SSH access"
}
