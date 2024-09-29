locals {
    directory_service_id = try(local[var.env].directory_service_id,"")
    
    create_directory_service_sg = length(local.directory_service_id) > 0 ? 1 : 0

    directory_service_enabled_regions = {
      for region in try(local[var.env].directory_service_enabled_regions,[]) : region => local.create_directory_service_sg
    }
    
    security_group_rules = {
        ingress_rules        = local.create_directory_service_sg ? try(yamldecode(file("rules/${var.env}/ingress.yaml"))["rules"],[]): []
        egress_rules         = local.create_directory_service_sg ? try(yamldecode(file("rules/${var.env}/egress.yaml"))["rules"],[]): []
    }
}

locals {
    ingress_rules = { for rule in local.security_group_rules.ingress_rules : format("from:%s:%s-%s::%s::to:%s", rule.cidr_block, rule.from_port, rule.to_port, rule.protocol, local.directory_service_id) => {
        cidr_ipv4   = rule.cidr_block
        from_port   = rule.protocol == "-1" ? null: rule.from_port
        ip_protocol = rule.protocol
        to_port     = rule.protocol == "-1" ? null: rule.to_port
        description = try(rule.description,null)
    } }

    egress_rules = { for rule in local.security_group_rules.egress_rules : format("from:%s:%s-%s::%s::to:%s", local.directory_service_id, rule.from_port, rule.to_port, rule.protocol, rule.cidr_block) => {
        cidr_ipv4   = rule.cidr_block
        from_port   = rule.protocol == "-1" ? null: rule.from_port
        ip_protocol = rule.protocol
        to_port     = rule.protocol == "-1" ? null: rule.to_port
        description = try(rule.description,null)
    } }
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group

data "aws_security_group" "us_west_2_sg" {
    count    = lookup(local.directory_service_enabled_regions, "us-west-2", 0)
    provider = aws.uswest1
    name = "${local.directory_service_id}_controllers"
}

data "aws_security_group" "us_east_1_sg" {
    count    = lookup(local.directory_service_enabled_regions, "us-east-1", 0)
    provider = aws.useast1
    name = "${local.directory_service_id}_controllers"
}

data "aws_security_group" "ca_central_1_sg" {
    count    = lookup(local.directory_service_enabled_regions, "ca-central-1", 0)
    provider = aws.cacentral1
    name = "${local.directory_service_id}_controllers"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule

# us-west-2
resource "aws_vpc_security_group_ingress_rule" "us_west_2_sg" {
  provider = aws.uswest1
  for_each = lookup(local.directory_service_enabled_regions, "us-west-2", 0) == 1 ?  local.ingress_rules: null
  security_group_id = data.aws_security_group.us_west_2_sg.id
  cidr_ipv4   = each.value.cidr_block
  from_port   = each.value.from_port
  ip_protocol = each.value.protocol
  to_port     = each.value.to_port
}

resource "aws_vpc_security_group_egress_rule" "us_west_2_sg" {
  provider = aws.uswest1
  for_each = lookup(local.directory_service_enabled_regions, "us-west-2", 0) == 1 ?  local.egress_rules: null
  security_group_id = data.aws_security_group.us_west_2_sg.id
  cidr_ipv4   = each.value.cidr_block
  from_port   = each.value.from_port
  ip_protocol = each.value.protocol
  to_port     = each.value.to_port
}


# us-east-1
resource "aws_vpc_security_group_ingress_rule" "us_east_1_sg" {
  provider = aws.useast1
  for_each = lookup(local.directory_service_enabled_regions, "us-east-1", 0) == 1 ?  local.ingress_rules: null
  security_group_id = data.aws_security_group.us_east_1_sg.id
  cidr_ipv4   = each.value.cidr_block
  from_port   = each.value.from_port
  ip_protocol = each.value.protocol
  to_port     = each.value.to_port
}

resource "aws_vpc_security_group_egress_rule" "us_east_1_sg" {
  provider = aws.useast1
  for_each = lookup(local.directory_service_enabled_regions, "us-east-1", 0) == 1 ?  local.egress_rules: null
  security_group_id = data.aws_security_group.us_east_1_sg.id
  cidr_ipv4   = each.value.cidr_block
  from_port   = each.value.from_port
  ip_protocol = each.value.protocol
  to_port     = each.value.to_port
}


# ca-central-1
resource "aws_vpc_security_group_ingress_rule" "ca_central_1_sg" {
  provider = aws.cacentral1
  for_each = lookup(local.directory_service_enabled_regions, "ca-central-1", 0) == 1 ?  local.ingress_rules: null
  security_group_id = data.aws_security_group.ca_central_1_sg.id
  cidr_ipv4   = each.value.cidr_block
  from_port   = each.value.from_port
  ip_protocol = each.value.protocol
  to_port     = each.value.to_port
}

resource "aws_vpc_security_group_egress_rule" "ca_central_1_sg" {
  provider = aws.cacentral1
  for_each = lookup(local.directory_service_enabled_regions, "ca-central-1", 0) == 1 ?  local.egress_rules: null
  security_group_id = data.aws_security_group.ca_central_1_sg.id
  cidr_ipv4   = each.value.cidr_block
  from_port   = each.value.from_port
  ip_protocol = each.value.protocol
  to_port     = each.value.to_port
}