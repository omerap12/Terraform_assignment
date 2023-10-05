terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

locals {
  region = "us-east-1"
  access_key = "AKIAQHPX54HHLXGG27NZ"
  secret_key = "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"
  availability_zone = "us-east-1a"
}

provider "aws" {
  region     = local.region
  access_key = local.access_key
  secret_key = local.secret_key
}

module "simple-webapp-module" {
  source = "./simple-webapp-module"
  region = local.region
  availability_zone = local.availability_zone
}