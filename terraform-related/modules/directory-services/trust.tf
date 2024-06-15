resource "aws_directory_service_trust" "this" {
  for_each     = { for trust in nonsensitive(var.trusts) : trust.remote_domain_name => trust }
  directory_id = aws_directory_service_directory.this.id

  remote_domain_name             = each.value.remote_domain_name
  trust_direction                = each.value.trust_direction
  trust_password                 = sensitive(each.value.trust_password)
  conditional_forwarder_ip_addrs = each.value.conditional_forwarder_ip_addrs
}
