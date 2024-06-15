provider "aws" {
  region                      = "us-east-1"
  skip_metadata_api_check     = true
  skip_region_validation      = true
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

module "secretsmanager" {
  source = "./modules/secretsmanager"
  name = "my-secret"
  secret_string = jsonencode({username = "raghav"})
}