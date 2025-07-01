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
  region = "us-east-2"
}

variable "vpc_id" {
  default = "vpc-0bfc335c635edbb74"
}

locals {
  subnets = [
    { name = "public-lb-2c",   cidr = "10.107.3.128/26",      az = "us-east-2c" },

  
    { name = "private-db-2b",  cidr = "10.107.2.16/28",       az = "us-east-2b" },
    { name = "private-db-2c",  cidr = "10.107.2.32/28",       az = "us-east-2c" },

    { name = "private-fs-2a",  cidr = "10.107.2.96/28",       az = "us-east-2a" },
    { name = "private-fs-2b",  cidr = "10.107.2.112/28",      az = "us-east-2b" },
    { name = "private-fs-2c",  cidr = "10.107.2.128/28",      az = "us-east-2c" },


    { name = "private-ad-2b",  cidr = "10.107.2.64/28",       az = "us-east-2b" },
    { name = "private-ad-2c",  cidr = "10.107.2.80/28",       az = "us-east-2c" },

    { name = "private-tgwy-2a", cidr = "10.107.255.208/28",   az = "us-east-2a" },
    { name = "private-tgwy-2b", cidr = "10.107.255.224/28",   az = "us-east-2b" },
    { name = "private-tgwy-2c", cidr = "10.107.255.240/28",   az = "us-east-2c" },


    { name = "public-nat-2b",  cidr = "10.107.0.48/28",       az = "us-east-2b" },


    { name = "private-apps-2a", cidr = "10.107.4.0/26",       az = "us-east-2a" },
    { name = "private-apps-2b", cidr = "10.107.4.64/26",      az = "us-east-2b" },
    { name = "private-apps-2c", cidr = "10.107.4.128/26",     az = "us-east-2c" },
  ]
}

resource "aws_subnet" "subnets" {
  for_each = { for subnet in local.subnets : subnet.name => subnet }

  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = false

  tags = {
    Name = each.key
  }
}
