# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/directory_service_directory.html#microsoft-active-directory-microsoftad
# primary directory service
resource "aws_directory_service_directory" "primary" {
  provider   = aws.use1
  name       = var.directory_domain_name
  short_name = var.directory_short_name
  password   = var.directory_password
  edition    = var.directory_edition
  type       = var.directory_type

  description = var.description

  desired_number_of_domain_controllers = var.number_of_domain_controllers

  vpc_settings {
    vpc_id     = local.vpc_ids["us-west-2"]
    subnet_ids = local.subnet_ids["us-west-2"]
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/directory_service_region
# replicated directory services
resource "aws_directory_service_region" "replicated" {
  provider     = aws.use1
  for_each     = { for replicated_region in var.replicated_regions : replicated_region.region_name => replicated_region }
  directory_id = aws_directory_service_directory.primary.id
  region_name  = each.key
  desired_number_of_domain_controllers = var.number_of_domain_controllers

  vpc_settings {
    vpc_id     = local.vpc_ids[each.key]
    subnet_ids = local.subnet_ids[each.key]
  }
  tags = var.tags

  lifecycle {
    precondition {
      condition     = aws_directory_service_directory.primary.type == "MicrosoftAD" && aws_directory_service_directory.primary.edition == "Enterprise"
      error_message = "Replication is only supported for Enterprise edition Microsoft AD directories"
    }
  }
}

## data.tf (sample to use secret manager to fetch the directory admin password)
# data "aws_secretsmanager_secret" "directory_password_secret" {
#   name = "/ds/${var.directory_domain_name}/admin"
# }
# data "aws_secretsmanager_secret_version" "directory_password" {
#   secret_id = data.aws_secretsmanager_secret.directory_password_secret.id
# }
## directory_password = data.aws_secretsmanager_secret_version.directory_password.secret_string