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