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

variable "size" {
  description = "The size of the directory, only applicable when type is set to SimpleAD/ADConnector"
  type        = string
  default     = null
}

variable "edition" {
  description = "The edition of the directory, only applicable when type is set to MicrosoftAD"
  type        = string
  default     = "Standard"
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


variable "trusts" {
  description = "A list of trusts to create between directories"
  type = list(object({
    remote_domain_name             = string
    trust_direction                = optional(string, "One-Way: Outgoing")
    trust_password                 = string
    conditional_forwarder_ip_addrs = list(string)
  }))
  default   = []
  sensitive = true
}

variable "replicated_regions" {
  description = "A list of regions to replicate the directory to"
  type = list(object({
    region_name                          = string
    vpc_id                               = string
    subnet_ids                           = list(string)
    desired_number_of_domain_controllers = optional(number, 2)
  }))
  default = []
}

variable "retention_in_days" {
  description = "The number of days to retain log events"
  type        = number
  default     = 30
}

variable "security_group_rules" {
  description = "The security group rules for the directory"
  type = object({
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = optional(string, null)
    }))
    egress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = optional(string, null)
    }))
  })
  default = {
    ingress_rules = []
    egress_rules  = []
  }
}