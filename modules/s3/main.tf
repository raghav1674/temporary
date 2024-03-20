resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Disabled"
  }
}

locals {
  # group the rule filters based on how many parameters are there in the filter
  # because the way of writing the filter block differs based on the number of parameters provided
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#with-neither-a-filter-nor-prefix-specified
  grouped_rule_filters = {
    for rule in var.lifecycle_rules : rule.id => {
      (length(compact([for v in try(rule.filter, []) : jsonencode(v) if v != null])) == 0 ? "with_zero_param" :
        length(compact([for v in try(rule.filter, []) : jsonencode(v) if v != null])) == 1 ? "with_one_param" :
      "with_multiple_param") = lookup(rule, "filter", [])
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_configuration" {
  depends_on = [aws_s3_bucket_versioning.versioning]
  bucket     = aws_s3_bucket.bucket.id

  dynamic "rule" {
    for_each = var.lifecycle_rules
    content {

      id = rule.value.id

      # Max 1 block - filter - without any key arguments or tags
      # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#with-neither-a-filter-nor-prefix-specified
      dynamic "filter" {
        for_each = try(local.grouped_rule_filters[rule.id]["with_zero_param"], [])
        content {
        }
      }


      # Max 1 block - filter - with one key argument or a single tag
      # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#specifying-a-filter-using-key-prefixes
      # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#specifying-a-filter-based-on-an-object-tag
      dynamic "filter" {
        for_each = try(local.grouped_rule_filters[rule.id]["with_one_param"], [])
        content {
          object_size_greater_than = try(filter.value.object_size_greater_than, null)
          object_size_less_than    = try(filter.value.object_size_less_than, null)
          prefix                   = try(filter.value.prefix, null)
          dynamic "tag" {
            for_each = try(filter.value.tags, [])
            content {
              key   = tag.key
              value = tag.value
            }
          }
        }
      }

      # Max 1 block - filter - with multiple arguments
      # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#specifying-a-filter-based-on-both-prefix-and-one-or-more-tags
      # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#specifying-a-filter-based-on-object-size-range-and-prefix
      dynamic "filter" {
        for_each = try(local.grouped_rule_filters[rule.id]["with_multiple_param"], [])
        content {
          and {
            object_size_greater_than = try(filter.value.object_size_greater_than, null)
            object_size_less_than    = try(filter.value.object_size_less_than, null)
            prefix                   = try(filter.value.prefix, null)
            tags                     = try(filter.value.tags, null)
          }
        }
      }

      dynamic "transition" {
        for_each = rule.value.transitions
        content {
          date          = try(transition.value.date, null)
          days          = try(transition.value.days, null)
          storage_class = transition.value.storage_class
        }
      }
      status = rule.value.status
    }
  }
}
