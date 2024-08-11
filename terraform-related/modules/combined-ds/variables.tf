variable "domain_name" {
  description = "The name of the directory"
  type        = string
}

variable "short_name" {
  description = "The short name of the directory"
  type        = string
  default     = null
}

variable "password" {
  description = "The password for the directory administrator"
  type        = string
  sensitive   = true
}

variable "edition" {
  description = "The edition of the directory, only applicable when type is set to MicrosoftAD"
  type        = string
  default     = "Enterprise"
}

variable "type" {
  description = "The directory type"
  type        = string
  default     = "MicrosoftAD"
}

variable "description" {
  description = "The description for the directory"
  type        = string
  default     = null
}

variable "number_of_domain_controllers" {
  description = "The desired number of domain controllers in the directory"
  type        = number
  default     = 2
}

variable "vpc_id" {
  description = "The VPC ID in which the directory will be created"
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnets in the VPC in which the directory will be created"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to the directory"
  type        = map(string)
  default     = {}
}


variable "replicated_regions" {
  description = "A list of regions to replicate the directory to"
  type = list(object({
    region_name = string
    vpc_id      = string
    subnet_ids  = list(string)
  }))
  default = []
}