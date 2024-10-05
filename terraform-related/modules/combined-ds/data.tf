data "aws_vpc" "vpc_usw2" {
  provider = aws.usw2
  filter {
    name   = "tag:Name"
    values = ["my_vpc_name"]
  }
}

data "aws_vpc" "vpc_use1" {
  provider = aws.use1
  filter {
    name   = "tag:Name"
    values = ["my_vpc_name"]
  }
}

data "aws_vpc" "vpc_cac1" {
  provider = aws.cac1
  filter {
    name   = "tag:Name"
    values = ["my_vpc_name"]
  }
}

data "aws_subnets" "subnets_usw2" {
  provider = aws.usw2
  filter {
    name   = "tag:Name"
    values = [""]
  }
}

data "aws_subnets" "subnets_use1" {
  provider = aws.use1
  filter {
    name   = "tag:Name"
    values = [""]
  }
}

data "aws_subnets" "subnets_cac1" {
  provider = aws.cac1
  filter {
    name   = "tag:Name"
    values = [""]
  }
}
