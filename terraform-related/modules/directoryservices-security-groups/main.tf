# us-west-2
resource "aws_vpc_security_group_ingress_rule" "us_west_2_sg" {
  provider = aws.uswest1
  for_each = local.ingress_rules
  security_group_id = data.aws_security_group.us_west_2_sg.id
  cidr_ipv4   = each.value.cidr_block
  from_port   = each.value.from_port
  ip_protocol = each.value.protocol
  to_port     = each.value.to_port
}

resource "aws_vpc_security_group_egress_rule" "us_west_2_sg" {
  provider = aws.uswest1
  for_each = local.egress_rules
  security_group_id = data.aws_security_group.us_west_2_sg.id
  cidr_ipv4   = each.value.cidr_block
  from_port   = each.value.from_port
  ip_protocol = each.value.protocol
  to_port     = each.value.to_port
}


# us-east-1
resource "aws_vpc_security_group_ingress_rule" "us_east_1_sg" {
  provider = aws.useast1
  for_each = local.ingress_rules
  security_group_id = data.aws_security_group.us_east_1_sg.id
  cidr_ipv4   = each.value.cidr_block
  from_port   = each.value.from_port
  ip_protocol = each.value.protocol
  to_port     = each.value.to_port
}

resource "aws_vpc_security_group_egress_rule" "us_east_1_sg" {
  provider = aws.useast1
  for_each = local.egress_rules
  security_group_id = data.aws_security_group.us_east_1_sg.id
  cidr_ipv4   = each.value.cidr_block
  from_port   = each.value.from_port
  ip_protocol = each.value.protocol
  to_port     = each.value.to_port
}


# ca-central-1
resource "aws_vpc_security_group_ingress_rule" "ca_central_1_sg" {
  provider = aws.cacentral1
  for_each = local.ingress_rules
  security_group_id = data.aws_security_group.ca_central_1_sg.id
  cidr_ipv4   = each.value.cidr_block
  from_port   = each.value.from_port
  ip_protocol = each.value.protocol
  to_port     = each.value.to_port
}

resource "aws_vpc_security_group_egress_rule" "ca_central_1_sg" {
  provider = aws.cacentral1
  for_each = local.egress_rules
  security_group_id = data.aws_security_group.ca_central_1_sg.id
  cidr_ipv4   = each.value.cidr_block
  from_port   = each.value.from_port
  ip_protocol = each.value.protocol
  to_port     = each.value.to_port
}