variable "directory_id" {
  description = "The name of the directory"
  type        = string
}

variable "region_name" {
  description = "The name of the region"
  type        = string
}

variable "retention_in_days" {
  description = "The number of days to retain log events"
  type        = number
  default     = 30
}


variable "tags" {
  description = "A map of tags to assign to the directory"
  type        = map(string)
  default     = {}
}
