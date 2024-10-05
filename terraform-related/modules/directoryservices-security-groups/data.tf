# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/prefix_list

data "aws_ec2_managed_prefix_list" "rfc1918_usw2" {
  provider = aws.usw2
  name     = local.prefix_list_name
}

data "aws_ec2_managed_prefix_list" "rfc1918_use1" {
  provider = aws.use1
  name     = local.prefix_list_name
}
data "aws_ec2_managed_prefix_list" "rfc1918_cac1" {
  provider = aws.cac1
  name     = local.prefix_list_name
}


#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group

data "aws_security_group" "sg_usw2" {
  provider = aws.usw2
  name     = "${local.directory_service_id}_controllers"
}

data "aws_security_group" "sg_use1" {
  provider = aws.use1
  name     = "${local.directory_service_id}_controllers"
}

data "aws_security_group" "sg_cac1" {
  provider = aws.cac1
  name     = "${local.directory_service_id}_controllers"
}