module "primary_directory_log" {
  source            = "../../modules/directory-services/logging"
  directory_id      = aws_directory_service_directory.this.id
  region_name       = local.region_name
  tags              = var.tags
  retention_in_days = var.retention_in_days
}

module "replica_directory_log" {
  for_each          = [for directory in aws_directory_service_region.this : directory.region_name]
  source            = "../../modules/directory-services/logging"
  directory_id      = aws_directory_service_directory.this.id
  region_name       = each.value
  tags              = var.tags
  retention_in_days = var.retention_in_days
}