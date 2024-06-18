resource "aws_security_group_rule" "ingress_rules" {
  for_each          = { for rule in var.security_group_rules.ingress_rules : format("from:%s:%s-%s::%s::to:%s", rule.cidr_block, rule.from_port, rule.to_port, rule.protocol, var.domain_name) => rule }
  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = [each.value.cidr_block]
  description       = each.value.description
  security_group_id = local.security_group_id
}

resource "aws_security_group_rule" "egress_rules" {
  for_each          = { for rule in var.security_group_rules.egress_rules : format("from:%s:%s-%s::%s::to:%s", var.domain_name, rule.from_port, rule.to_port, rule.protocol, rule.cidr_block) => rule }
  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = [each.value.cidr_block]
  description       = each.value.description
  security_group_id = local.security_group_id
}