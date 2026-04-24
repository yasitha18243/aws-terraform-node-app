variable "project_name" {}
variable "environment" {}
variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "app_bucket_arn" {}
variable "app_bucket_name" {}
variable "instance_type" {}
