terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "0.11.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}