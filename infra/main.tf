terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.29"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}

