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
  type = object({
    transitions = optional(list(object({
      days          = number
      storage_class = string
    })),[])
    noncurrent_transitions = optional(list(object({
      noncurrent_days = number
      storage_class   = string
    })),[])
    noncurrent_expiration_days = optional(number,180)
  })
  default     = null
  description = "Lifecycle Rule to be applied for the entire bucket"
}