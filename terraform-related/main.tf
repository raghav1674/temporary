provider "aws" {
  region                  = "us-east-1"
  skip_metadata_api_check = true
  skip_region_validation  = true
  # skip_credentials_validation = true
  # skip_requesting_account_id  = true
}

# module "s3" {
#   source             = "./modules/s3"
#   bucket_name        = "aws-test-bucket-dixit-lifecycle"
#   versioning_enabled = false
#   lifecycle_rule     = {
#     transition_days = 90 
#     transition_storage_class = "GLACIER"
#     noncurrent_version_transition_days = 100
#     noncurrent_version_transition_storage_class = "GLACIER" 
#     noncurrent_expiration_days = 200 
#   }
# }

# module "secretsmanager" {
#   source = "./modules/secretsmanager"
#   name = "my-secret"
#   secret_string = jsonencode({username = "raghav"})
# }

module "directory-services" {
  source = "./modules/directory-services"

  domain_name = "example.com"
  short_name  = "example"
  description = "My Microsoft AD"
  password    = "Sample$#123" # should be test from environment variable

  edition = "Enterprise"

  vpc_id     = "vpc-0b8a0bd2e98df43ae"
  subnet_ids = ["subnet-0a9bd49cf8c526caf", "subnet-0a155019dc0a1ac8c"]

  tags = {
    Name = "MyDirectory"
  }
  trusts = [
    {
      remote_domain_name             = "google.com"
      trust_password                 = "password"
      conditional_forwarder_ip_addrs = ["8.8.8.8"]
    }
  ]
  replicated_regions = [
    {
      region_name = "us-west-2"
      vpc_id      = "vpc-0d02498a75ff3a896"
      subnet_ids  = ["subnet-0346df40faa7988a1", "subnet-0cb155aa8b5244f5b"]
    }
  ]
  security_group_rules = {
    ingress_rules = []
    egress_rules = [
      {
        from_port  = 0
        to_port    = 0
        protocol   = "-1"
        cidr_block = "10.0.0.0/8"
      }
    ]
  }
}
