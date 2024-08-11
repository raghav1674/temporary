# primary directory service
resource "aws_directory_service_directory" "this" {
  name       = var.domain_name
  short_name = var.short_name
  password   = var.password
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

# replicated directory services
resource "aws_directory_service_region" "this" {
  for_each     = { for replicated_region in var.replicated_regions : replicated_region.region_name => replicated_region }
  directory_id = aws_directory_service_directory.this.id
  region_name  = each.key

  vpc_settings {
    vpc_id     = each.value.vpc_id
    subnet_ids = each.value.subnet_ids
  }
  tags = var.tags

  lifecycle {
    precondition {
      condition     = aws_directory_service_directory.this.type == "MicrosoftAD" && aws_directory_service_directory.this.edition == "Enterprise"
      error_message = "Replication is only supported for Enterprise edition Microsoft AD directories"
    }
  }
}

// tfvars file
#   domain_name = "example.com"
#   short_name  = "example"
#   description = "My Microsoft AD"
#   password    = "Sample$#123" # should be test from environment variable
#   vpc_id     = "vpc-0b8a0bd2e98df43ae"
#   subnet_ids = ["subnet-0a9bd49cf8c526caf", "subnet-0a155019dc0a1ac8c"]
#   tags = {
#     Name = "MyDirectory"
#   }
#   replicated_regions = [
#     {
#       region_name = "us-west-2"
#       vpc_id      = "vpc-0d02498a75ff3a896"
#       subnet_ids  = ["subnet-0346df40faa7988a1", "subnet-0cb155aa8b5244f5b"]
#     }
#   ]