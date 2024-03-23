variable "bucket_name" {
  type = string
}

variable "versioning_enabled" {
  type = bool
}

# variable "lifecycle_rules" {
#   type = any 
#   default = []
# }


variable "lifecycle_rule" {
  type = any
  default = {}
}