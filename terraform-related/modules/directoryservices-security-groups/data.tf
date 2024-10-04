# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/prefix_list

data "aws_prefix_list" "rfc1918_usw2" {
  count    = contains(local.directory_service_enabled_regions, "us-west-2") ? 1 : 0
  provider = aws.usw2
  name     = local.prefix_list_name
}

data "aws_prefix_list" "rfc1918_use1" {
  count    = contains(local.directory_service_enabled_regions, "us-east-1") ? 1 : 0
  provider = aws.use1
  name     = local.prefix_list_name
}
data "aws_prefix_list" "rfc1918_cac1" {
  count    = contains(local.directory_service_enabled_regions, "ca-central-1") ? 1 : 0
  provider = aws.cac1
  name     = local.prefix_list_name
}


#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group

data "aws_security_group" "usw2_sg" {
  count    = contains(local.directory_service_enabled_regions, "us-west-2") ? 1 : 0
  provider = aws.usw2
  name     = "${local.directory_service_id}_controllers"
}

data "aws_security_group" "use1_sg" {
  count    = contains(local.directory_service_enabled_regions, "us-east-1") ? 1 : 0
  provider = aws.use1
  name     = "${local.directory_service_id}_controllers"
}

data "aws_security_group" "cac1_sg" {
  count    = contains(local.directory_service_enabled_regions, "ca-central-1") ? 1 : 0
  provider = aws.cac1
  name     = "${local.directory_service_id}_controllers"
}