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
resource "aws_vpc" "imported_vpc" {
  # Leave blank for import; actual config will show after `terraform import`
}

resource "aws_subnet" "subnet-0bb098e3e1fba0687" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-0c7b192d670f9d0cb" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-0c24b17cd5d46f1ff" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-0eaea7bb8be5084d8" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-06b95eaa4965f7536" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-0bfee77d0937fd775" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-0b05898e42357f678" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-0406ae58ddf35b538" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-0cf870f1095c649e3" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-04d2e8237cc00fb8e" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-07cb9fa8212fafc74" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-0a4155b07b7bf2d00" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-0df1186bbfe26e33b" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-0f16036679a6e77fa" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-05ec42551fb2546e6" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "ssubnet-0a446ab3a23daca30" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-0f06732ddea81ced6" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-011cb41849ed7d712" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-071b5388526d50c50" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-09171bcade2a01ccf" {
  vpc_id = vpc-0be4bfc8ad924beaa
}
resource "aws_subnet" "subnet-0a793f2a7c97994d7" {
  vpc_id = vpc-0be4bfc8ad924beaa
}


resource "aws_security_group" "sg-01a497089e489e037" {
  # Terraform will fill this after import
}
resource "aws_security_group" "sg-0578b1f4190ce26e3" {
  # Terraform will fill this after import
}
resource "aws_security_group" "sg-0fdb775ff017d764b" {
  # Terraform will fill this after import
}
resource "aws_security_group" "sg-0c513faee137f0e49" {
  # Terraform will fill this after import
}
resource "aws_security_group" "sg-0a559a3516652b694" {
  # Terraform will fill this after import
}
resource "aws_security_group" "sg-0d5a2bb816429895b" {
  # Terraform will fill this after import
}


