provider "aws" {
  region = "us-east-1"
}

module "s3" {
  source             = "./modules/s3"
  bucket_name        = "aws-test-bucket-dixit-lifecycle"
  versioning_enabled = false

  lifecycle_rule = {
    transition = [
      {
        days          = 0
        storage_class = "GLACIER_IR"
      }
    ]
  }
}