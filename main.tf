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
      transitions = [
        {
          days          = 100
          storage_class = "STANDARD_IA"
        }
      ]
    },
    {
      id = "only objects with prefix as logs/"
      filter = {
        prefix = "logs/"
      }
      transitions = [
        {
          days          = 50
          storage_class = "STANDARD_IA"
        }
      ]
    },
    {
      id = "only objects with tag as key1=value1"
      filter = {
        tags = {
          key1 = "value1"
        }
      }
      transitions = [
        {
          days          = 50
          storage_class = "STANDARD_IA"
        }
      ]
    },
    {
      id = "only objects with more than one  tags "
      filter = {
        tags = {
          key1 = "value1"
          key2 = "value2"
        }
      }
      transitions = [
        {
          days          = 50
          storage_class = "STANDARD_IA"
        }
      ]
    },
    {
      id = "only objects with more than one tags and prefix"
      filter = {
        prefix = "test/"
        tags = {
          key1 = "value1"
          key2 = "value2"
        }
      }
      transitions = [
        {
          days          = 50
          storage_class = "STANDARD_IA"
        }
      ]
    },
    {
      id = "only objects with more than one tags and prefix and some additional fields"
      filter = {
        prefix                   = "test/"
        object_size_greater_than = 1000000
        tags = {
          key1 = "value1"
          key2 = "value2"
        }
      }
      transitions = [
        {
          days          = 50
          storage_class = "STANDARD_IA"
        }
      ]
    },
    {
      id = "only objects with more than one transitions"
      transitions = [
        {
          days          = 50
          storage_class = "STANDARD_IA"
        },
        {
          days          = 100
          storage_class = "GLACIER_IR"
        }
      ]
    }
  ]

}