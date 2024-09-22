data "aws_security_group" "us_west_2_sg" {
    provider = aws.uswest1
    name = "${local.directory_service_id}_controllers"
}

data "aws_security_group" "us_east_1_sg" {
    provider = aws.useast1
    name = "${local.directory_service_id}_controllers"
}

data "aws_security_group" "ca_central_1_sg" {
    provider = aws.cacentral1
    name = "${local.directory_service_id}_controllers"
}