variable "bucket_name" {
  type = string
}

variable "versioning_enabled" {
  type = bool
}

variable "lifecycle_rules" {
  type = list(object({
    id     = string
    status = optional(string, "Enabled")
    filter = optional(object({
      object_size_greater_than = optional(number, null)
      object_size_less_than    = optional(number, null)
      prefix                   = optional(string, null)
      tags                     = optional(map(string), null)
    }), {})
    transitions = list(object({
      date          = optional(string, null)
      days          = optional(number, null)
      storage_class = string
    }))
  }))

  default = null
}