locals {
  alpha = yamldecode(file("${path.module}/../../environments/brm.yaml"))
}

module "subnet" {
  source = "../../modules/subnets/"
  alpha  = local.alpha
}

output "public_nat_2a_id" {
  value = module.subnet.public_nat_2a_id
}
