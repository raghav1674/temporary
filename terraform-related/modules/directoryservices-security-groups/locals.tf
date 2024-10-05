locals {
  prefix_list_name     = local.config.prefix_list_name
  directory_service_id = local.config.directory_service.id
  ds_ingress_rules     = local.config.directory_service.security_group_rules.ingress
  ds_egress_rules      = local.config.directory_service.security_group_rules.egress
}

