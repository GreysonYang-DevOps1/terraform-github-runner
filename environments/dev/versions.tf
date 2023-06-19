terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.0"
    }
    local = {
      version = "~> 2.1"
    }
  }

  required_version = ">= 1.4.0"
}