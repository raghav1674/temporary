resource "aws_directory_service_directory" "this" {
  name       = var.domain_name
  short_name = var.short_name
  password   = var.password
  size       = var.size
  edition    = var.edition
  type       = var.type

  description = var.description

  desired_number_of_domain_controllers = var.number_of_domain_controllers

  vpc_settings {
    vpc_id     = var.vpc_id
    subnet_ids = var.subnet_ids
  }

  tags = var.tags
}