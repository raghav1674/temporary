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
  type        = any
  default     = null
  description = "Lifecycle Rule to be applied for the entire bucket"
}