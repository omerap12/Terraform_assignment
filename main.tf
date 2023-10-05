terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

locals {
  region = "us-east-1"
  access_key = "access_key"
  secret_key = "saccess_key"
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