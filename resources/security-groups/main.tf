locals {
  config = yamldecode(file("${path.module}/../../environments/brm.yaml"))
}

module "security_groups" {
  source = "../../modules/security-groups"
  alpha  = local.config
}