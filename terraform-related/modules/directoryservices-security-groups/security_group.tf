# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule

# us-west-2 directory service ingress and egress rules

resource "aws_vpc_security_group_ingress_rule" "sg_usw2" {
  provider = aws.usw2
  count    = length(local.ds_ingress_rules)

  security_group_id = data.aws_security_group.sg_usw2.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.rfc1918_usw2.id
  from_port         = local.ds_ingress_rules[count.index].ip_protocol == -1 ? local.ds_ingress_rules[count.index].from_port : null
  ip_protocol       = local.ds_ingress_rules[count.index].ip_protocol
  to_port           = local.ds_ingress_rules[count.index].ip_protocol == -1 ? local.ds_ingress_rules[count.index].to_port : null
}

resource "aws_vpc_security_group_egress_rule" "sg_usw2" {
  provider = aws.usw2
  count    = length(local.ds_egress_rules)

  security_group_id = data.aws_security_group.sg_usw2.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.rfc1918_usw2.id
  from_port         = local.ds_egress_rules[count.index].ip_protocol == -1 ? local.ds_egress_rules[count.index].from_port : null
  ip_protocol       = local.ds_egress_rules[count.index].ip_protocol
  to_port           = local.ds_egress_rules[count.index].ip_protocol == -1 ? local.ds_egress_rules[count.index].to_port : null
}


# us-east-1 directory service ingress and egress rules

resource "aws_vpc_security_group_ingress_rule" "sg_use1" {
  provider = aws.use1
  count    = length(local.ds_ingress_rules)

  security_group_id = data.aws_security_group.sg_use1.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.rfc1918_use1.id
  from_port         = local.ds_ingress_rules[count.index].ip_protocol == -1 ? local.ds_ingress_rules[count.index].from_port : null
  ip_protocol       = local.ds_ingress_rules[count.index].ip_protocol
  to_port           = local.ds_ingress_rules[count.index].ip_protocol == -1 ? local.ds_ingress_rules[count.index].to_port : null
}

resource "aws_vpc_security_group_egress_rule" "sg_use1" {
  provider = aws.use1
  count    = length(local.ds_egress_rules)

  security_group_id = data.aws_security_group.sg_use1.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.rfc1918_use1.id
  from_port         = local.ds_egress_rules[count.index].ip_protocol == -1 ? local.ds_egress_rules[count.index].from_port : null
  ip_protocol       = local.ds_egress_rules[count.index].ip_protocol
  to_port           = local.ds_egress_rules[count.index].ip_protocol == -1 ? local.ds_egress_rules[count.index].to_port : null
}


# ca-central-1 directory service ingress and egress rules

resource "aws_vpc_security_group_ingress_rule" "sg_cac1" {
  provider = aws.cac1
  count    = length(local.ds_ingress_rules)

  security_group_id = data.aws_security_group.sg_cac1.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.rfc1918_cac1.id
  from_port         = local.ds_ingress_rules[count.index].ip_protocol == -1 ? local.ds_ingress_rules[count.index].from_port : null
  ip_protocol       = local.ds_ingress_rules[count.index].ip_protocol
  to_port           = local.ds_ingress_rules[count.index].ip_protocol == -1 ? local.ds_ingress_rules[count.index].to_port : null
}

resource "aws_vpc_security_group_egress_rule" "sg_cac1" {
  provider = aws.cac1
  count    = length(local.ds_egress_rules)

  security_group_id = data.aws_security_group.sg_cac1.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.rfc1918_cac1.id
  from_port         = local.ds_egress_rules[count.index].ip_protocol == -1 ? local.ds_egress_rules[count.index].from_port : null
  ip_protocol       = local.ds_egress_rules[count.index].ip_protocol
  to_port           = local.ds_egress_rules[count.index].ip_protocol == -1 ? local.ds_egress_rules[count.index].to_port : null
}