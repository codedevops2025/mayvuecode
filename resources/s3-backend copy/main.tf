locals {
  env = merge (
    yamldecode(file("${path.module}/../../environments/region.yaml")).alias,
    yamldecode(file("${path.module}/../../environments/mayvue.yaml"))
  )  
}

terraform {
  required_version = ">= 1.10.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = local.env.s3.aws_region_main
}

provider "aws" {
  alias  = "state"
  region = var.config.aws_region_main
}

provider "aws" {
  alias  = "backup"
  region = var.config.aws_region_backup
}

module "s3-backend" {
  source = "../../modules/s3-backend"
  config = local.env.s3
  tags   = local.env.tags
}