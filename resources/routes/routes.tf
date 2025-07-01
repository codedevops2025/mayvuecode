locals {
  config = yamldecode(file("${path.module}/../../environments/brm.yaml"))
}

module "routes" {
  source = "../../modules/routes"
  config = local.config
}