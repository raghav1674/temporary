locals {
    vpc_ids ={
        "us-west-2" = data.aws_vpc.vpc_usw2.arn
        "us-east-1" = data.aws_vpc.vpc_use1.arn
        "ca-central-1" = data.aws_vpc.vpc_cac1.arn
    }

    subnet_ids = {
        "us-west-2" = data.aws_subnets.subnets_usw2.ids
        "us-east-1" = data.aws_subnets.subnets_use1.ids
        "ca-central-1" = data.aws_subnets.subnets_cac1.ids
    }
}