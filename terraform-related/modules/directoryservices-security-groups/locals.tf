locals {
    directory_service_id = local[var.env].directory_service_id
    security_group_rules = {
        ingress_rules        = try(yamldecode(file("rules/${var.env}/ingress.yaml"))["rules"],[])
        egress_rules         = try(yamldecode(file("rules/${var.env}/egress.yaml"))["rules"],[])
    }
}

locals {

    ingress_rules = { for rule in var.security_group_rules.ingress_rules : format("from:%s:%s-%s::%s::to:%s", rule.cidr_block, rule.from_port, rule.to_port, rule.protocol, var.domain_name) => {
        cidr_ipv4   = rule.cidr_block
        from_port   = rule.protocol == "-1" ? null: rule.from_port
        ip_protocol = rule.protocol
        to_port     = rule.protocol == "-1" ? null: rule.to_port
        description = try(rule.description,null)
    } }


    egress_rules = { for rule in var.security_group_rules.egress_rules : format("from:%s:%s-%s::%s::to:%s", var.domain_name, rule.from_port, rule.to_port, rule.protocol, rule.cidr_block) => {
        cidr_ipv4   = rule.cidr_block
        from_port   = rule.protocol == "-1" ? null: rule.from_port
        ip_protocol = rule.protocol
        to_port     = rule.protocol == "-1" ? null: rule.to_port
        description = try(rule.description,null)
    } }
}

