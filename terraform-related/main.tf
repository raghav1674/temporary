provider "aws" {
  region                      = "us-east-1"
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

module "s3" {
  source             = "./modules/s3"
  bucket_name        = "aws-test-bucket-dixit-lifecycle"
  versioning_enabled = false
}