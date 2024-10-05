data "aws_vpc" "us-west-2" {
  provider = aws.usw2
  filter {
    name   = "tag:Name"
    values = ["my_vpc_name"]
  }
}

data "aws_vpc" "us-east-1" {
  provider = aws.use1
  filter {
    name   = "tag:Name"
    values = ["my_vpc_name"]
  }
}

data "aws_vpc" "ca-central-1" {
  provider = aws.cac1
  filter {
    name   = "tag:Name"
    values = ["my_vpc_name"]
  }
}

data "aws_subnets" "us-west-2" {
  provider = aws.usw2
  filter {
    name   = "tag:Name"
    values = [""]
  }
}

data "aws_subnets" "us-east-1" {
  provider = aws.use1
  filter {
    name   = "tag:Name"
    values = [""]
  }
}

data "aws_subnets" "ca-central-1" {
  provider = aws.cac1
  filter {
    name   = "tag:Name"
    values = [""]
  }
}
