# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule

# us-west-2 directory service ingress and egress rules

resource "aws_vpc_security_group_ingress_rule" "usw2_sg" {
  provider = aws.usw2
  for_each = contains(local.directory_service_enabled_regions, "us-west-2") ? local.ds_ingress_rules : null

  security_group_id = data.aws_security_group.usw2_sg[0].id
  prefix_list_id    = try(each.value.use_prefix_list, false) ? data.aws_prefix_list.rfc1918_usw2[0].id : null
  cidr_ipv4         = try(each.value.cidr_ipv4, null)
  from_port         = each.value.ip_protocol == -1 ? each.value.from_port : null
  ip_protocol       = each.value.ip_protocol
  to_port           = each.value.ip_protocol == -1 ? each.value.to_port : null
}

resource "aws_vpc_security_group_egress_rule" "usw2_sg" {
  provider = aws.usw2
  for_each = contains(local.directory_service_enabled_regions, "us-west-2") ? local.ds_egress_rules : null

  security_group_id = data.aws_security_group.usw2_sg[0].id
  prefix_list_id    = try(each.value.use_prefix_list, false) ? data.aws_prefix_list.rfc1918_usw2[0].id : null
  cidr_ipv4         = try(each.value.cidr_ipv4, null)
  from_port         = each.value.ip_protocol == -1 ? each.value.from_port : null
  ip_protocol       = each.value.ip_protocol
  to_port           = each.value.ip_protocol == -1 ? each.value.to_port : null
}


# us-east-1 directory service ingress and egress rules

resource "aws_vpc_security_group_ingress_rule" "use1_sg" {
  provider = aws.use1
  for_each = contains(local.directory_service_enabled_regions, "us-east-1") ? local.ds_ingress_rules : null

  security_group_id = data.aws_security_group.use1_sg[0].id
  prefix_list_id    = try(each.value.use_prefix_list, false) ? data.aws_prefix_list.rfc1918_use1[0].id : null
  cidr_ipv4         = try(each.value.cidr_ipv4, null)
  from_port         = each.value.ip_protocol == -1 ? each.value.from_port : null
  ip_protocol       = each.value.ip_protocol
  to_port           = each.value.ip_protocol == -1 ? each.value.to_port : null
}

resource "aws_vpc_security_group_egress_rule" "use1_sg" {
  provider = aws.use1
  for_each = contains(local.directory_service_enabled_regions, "us-east-1") ? local.ds_egress_rules : null

  security_group_id = data.aws_security_group.use1_sg[0].id
  prefix_list_id    = try(each.value.use_prefix_list, false) ? data.aws_prefix_list.rfc1918_use1[0].id : null
  cidr_ipv4         = try(each.value.cidr_ipv4, null)
  from_port         = each.value.ip_protocol == -1 ? each.value.from_port : null
  ip_protocol       = each.value.ip_protocol
  to_port           = each.value.ip_protocol == -1 ? each.value.to_port : null
}


# ca-central-1 directory service ingress and egress rules

resource "aws_vpc_security_group_ingress_rule" "cac1_sg" {
  provider = aws.cac1
  for_each = contains(local.directory_service_enabled_regions, "ca-central-1") ? local.ds_ingress_rules : null

  security_group_id = data.aws_security_group.cac1_sg[0].id
  prefix_list_id    = try(each.value.use_prefix_list, false) ? data.aws_prefix_list.rfc1918_cac1[0].id : null
  cidr_ipv4         = try(each.value.cidr_ipv4, null)
  from_port         = each.value.ip_protocol == -1 ? each.value.from_port : null
  ip_protocol       = each.value.ip_protocol
  to_port           = each.value.ip_protocol == -1 ? each.value.to_port : null
}

resource "aws_vpc_security_group_egress_rule" "cac1_sg" {
  provider = aws.cac1
  for_each = contains(local.directory_service_enabled_regions, "ca-central-1") ? local.ds_egress_rules : null

  security_group_id = data.aws_security_group.cac1_sg[0].id
  prefix_list_id    = try(each.value.use_prefix_list, false) ? data.aws_prefix_list.rfc1918_cac1[0].id : null
  cidr_ipv4         = try(each.value.cidr_ipv4, null)
  from_port         = each.value.ip_protocol == -1 ? each.value.from_port : null
  ip_protocol       = each.value.ip_protocol
  to_port           = each.value.ip_protocol == -1 ? each.value.to_port : null
}