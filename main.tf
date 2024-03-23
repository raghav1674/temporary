provider "aws" {
  region = "us-east-1"
}

module "s3" {
  source             = "./modules/s3"
  bucket_name        = "aws-test-bucket-dixit-lifecycle"
  versioning_enabled = false

  lifecycle_rules = [
    {
      id = "Entire bucket"
      transition = [
        {
          days          = 0
          storage_class = "GLACIER_IR"
        }
      ]
    },
    {
      id = "only objects with prefix as logs/"
      filter = {
        prefix = "logs/"
      }
      transition = [
        {
          days          = 90
          storage_class = "STANDARD_IA"
        },
        {
          days          = 180
          storage_class = "GLACIER"
        }
      ]
    },
    {
      id = "only objects with prefix as reports/"
      filter = {
        prefix = "reports/"
      }
      transition = [
        {
          days          = 365
          storage_class = "GLACIER"
        }
      ]
    },
    {
      id = "only objects with tag as imp=true "
      filter = {
        tags = {
          imp = true
        }
      }
      transition = [
        {
          days          = 760
          storage_class = "GLACIER"
        }
      ]
    }
  ]

}