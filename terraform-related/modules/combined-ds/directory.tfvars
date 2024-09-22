directory_domain_name = "sample.com"
directory_short_name  = "sample"
description           = "My Microsoft AD"
vpc_id                = "vpc-xxxxxxxx"
subnet_ids            = ["subnet-xxxxxxx", "subnet-xxxxxxx"]
tags = {
  Name = "MyDirectory"
}
replicated_regions = [
  {
    region_name = "us-east-1"
    vpc_id      = "vpc-xxxxxxxx"
    subnet_ids  = ["subnet-xxxxxx", "subnet-xxxxxxxx"]
  },
  {
    region_name = "ca-central-1"
    vpc_id      = "vpc-xxxxxxxx"
    subnet_ids  = ["subnet-xxxxxx", "subnet-xxxxxxxx"]
  }
]
# export TF_VAR_directory_password="xxxxx"
