resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Disabled"
  }
}


# resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_configuration" {

#   bucket                = aws_s3_bucket.bucket.id

#   dynamic "rule" {
#     for_each = var.lifecycle_rules

#     content {
#       id     = try(rule.value.id, null)
#       status = try(rule.value.status,"Enabled")

#       # Several blocks - transition
#       dynamic "transition" {
#         for_each = try(flatten([rule.value.transition]), [])

#         content {
#           date          = try(transition.value.date, null)
#           days          = try(transition.value.days, null)
#           storage_class = transition.value.storage_class
#         }
#       }

#       # Several blocks - transition
#       dynamic "noncurrent_version_transition" {
#         for_each = try(flatten([rule.value.noncurrent_version_transition]), [])

#         content {
#           date          = try(noncurrent_version_transition.value.date, null)
#           days          = try(noncurrent_version_transition.value.days, null)
#           storage_class = noncurrent_version_transition.value.storage_class
#         }
#       }

#       # Max 1 block - filter - without any key arguments or tags
#       dynamic "filter" {
#         for_each = length(try(flatten([rule.value.filter]), [])) == 0 ? [true] : []
#         content {
#         }
#       }

#       # Max 1 block - filter - with one key argument or a single tag
#       dynamic "filter" {
#         for_each = [for v in try(flatten([rule.value.filter]), []) : v if max(length(keys(v)), length(try(rule.value.filter.tags, rule.value.filter.tag, []))) == 1]

#         content {
#           object_size_greater_than = try(filter.value.object_size_greater_than, null)
#           object_size_less_than    = try(filter.value.object_size_less_than, null)
#           prefix                   = try(filter.value.prefix, null)

#           dynamic "tag" {
#             for_each = try(filter.value.tags, filter.value.tag, [])

#             content {
#               key   = tag.key
#               value = tag.value
#             }
#           }
#         }
#       }

#       # Max 1 block - filter - with more than one key arguments or multiple tags
#       dynamic "filter" {
#         for_each = [for v in try(flatten([rule.value.filter]), []) : v if max(length(keys(v)), length(try(rule.value.filter.tags, rule.value.filter.tag, []))) > 1]

#         content {
#           and {
#             object_size_greater_than = try(filter.value.object_size_greater_than, null)
#             object_size_less_than    = try(filter.value.object_size_less_than, null)
#             prefix                   = try(filter.value.prefix, null)
#             tags                     = try(filter.value.tags, filter.value.tag, null)
#           }
#         }
#       }
#     }


#   # Must have bucket versioning enabled first
#   depends_on = [aws_s3_bucket_versioning.versioning]
#   }
# }


resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_configuration" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    id = "TransitionAllObjects"

    status = "Enabled"

    # apply to all the objects in the bucket
    filter {}

    # for current versions objects
    dynamic "transition" {
      for_each = try(var.lifecycle_rule.transitions, [])
      content {
        days          = transition.each.days
        storage_class = transition.each.storage_class
      }
    }

    # for noncurrent versions objects
    dynamic "noncurrent_version_transition" {
      for_each = try(var.lifecycle_rule.noncurrent_transitions, [
        {
          days          = 90
          storage_class = "STANDARD_IA"
        },
        {
          days          = 120
          storage_class = "GLACIER"
        }
      ])
      content {
        noncurrent_days = noncurrent_version_transition.each.noncurrent_days
        storage_class   = noncurrent_version_transition.each.storage_class
      }
    }

    # for noncurrent version expiration
    noncurrent_version_expiration {
      noncurrent_days = try(var.lifecycle_rule.noncurrent_expiration_days, 180)
    }
  }
  depends_on = [aws_s3_bucket_versioning.versioning]
}