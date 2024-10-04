locals {
  prefix_list_name                  = local.config[var.env].prefix_list_name
  directory_service_enabled_regions = try(local.config[var.env].directory_service_enabled_regions, [])

  directory_service_id           = try(local.config[var.env].directory_service_id, "")
  add_directory_service_sg_rules = length(local.directory_service_id) > 0 ? 1 : 0

  ds_ingress_rules = local.add_directory_service_sg_rules ? local.config[var.env].security_group_rules.ingress : []
  ds_egress_rules  = local.add_directory_service_sg_rules ? local.config[var.env].security_group_rules.egress : []
}

