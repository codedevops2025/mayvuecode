locals {
  config = yamldecode(file("${path.module}/../../environments/brm.yaml"))
}

module "ec2" {
  source = "../../modules/ec2"
  config = local.config
}