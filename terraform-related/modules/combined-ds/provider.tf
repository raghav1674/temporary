terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  alias = "uswest"
}

provider "aws" {
  region = "us-east-1"
  alias = "useast"
}

provider "aws" {
  region = "ca-central-1"
  alias = "cacentral"
}
