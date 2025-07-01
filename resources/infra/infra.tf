locals {
  alpha = yamldecode(file("${path.module}/../../environments/brm.yaml"))
}

data "aws_subnet" "public_nat_2a" {
  filter {
    name   = "tag:Name"
    values = ["public-nat-2a"]
  }

  filter {
    name   = "vpc-id"
    values = [local.alpha.vpc.id]
  }
}

module "infra" {
  source = "../../modules/infra"
  infra = local.alpha
  public_nat_2a_id = data.aws_subnet.public_nat_2a.id
}