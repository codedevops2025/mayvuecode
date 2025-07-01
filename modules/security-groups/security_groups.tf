locals {
  current_vpc_cidr = var.alpha.vpc.cidr
  infra_vpc_cidr   = var.alpha.routes.infra_cidr_block
  sg_name_prefix = "${var.alpha.tags.env}-${var.alpha.tags.project}"

  security_groups = {
    db-orcl = {
      description = "Allows DB Access to Oracle"
      name = "${local.sg_name_prefix}-db-orcl"
      ingress = [
        {
          protocol = "tcp"
          from_port = 1521
          to_port = 1521
          cidr_blocks = [local.infra_vpc_cidr, local.current_vpc_cidr]
        }
      ]
      egress = [
        {
          protocol = "-1"
          from_port = 0
          to_port = 0
          cidr_blocks = [local.current_vpc_cidr, local.infra_vpc_cidr]
        }
      ]
    }

    db-sql = {
      description = "Allows DB Access to SQL"
      name = "${local.sg_name_prefix}-db-sql"
      ingress = [
        {
          protocol = "tcp"
          from_port = 1433
          to_port = 1433
          cidr_blocks = [local.infra_vpc_cidr, local.current_vpc_cidr]
        }
      ]
      egress = [
        {
          protocol = "-1"
          from_port = 0
          to_port = 0
          cidr_blocks = [local.infra_vpc_cidr, local.current_vpc_cidr]
        }
      ]
    }

    fsx = {
      description = "Allows DB Access to file systems"
      name = "${local.sg_name_prefix}-fsx"
      ingress = [
        {
          protocol = "tcp"
          from_port = 445
          to_port = 445
          cidr_blocks = [local.current_vpc_cidr]
        }
      ]
      egress = [
        {
          protocol = "-1"
          from_port = 0
          to_port = 0
          cidr_blocks = [local.current_vpc_cidr]
        }
      ]
    }

    rdp = {
      description = "Allows remote connections to infrastructure"
      name = "${local.sg_name_prefix}-rdp"
      ingress = [
        {
          protocol = "tcp"
          from_port = 22
          to_port = 22
          cidr_blocks = [local.infra_vpc_cidr, local.current_vpc_cidr]
        },
        {
          protocol = "tcp"
          from_port = 3389
          to_port = 3389
          cidr_blocks = [local.infra_vpc_cidr, local.current_vpc_cidr, "0.0.0.0/0"]
        }
      ]
      egress = []
    }

    www = {
      description = "Allows traffic from internet"
      name = "${local.sg_name_prefix}-www"
      ingress = [
        {
          protocol = "tcp"
          from_port = 80
          to_port = 80
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          protocol = "tcp"
          from_port = 443
          to_port = 443
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
      egress = [
        {
          protocol = "-1"
          from_port = 0
          to_port = 0
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }

    www-internal = {
      description = "Allows web access to servers"
      name = "${local.sg_name_prefix}-www-internal"
      ingress = [
        {
          protocol = "tcp"
          from_port = 80
          to_port = 80
          cidr_blocks = [local.current_vpc_cidr]
        },
        {
          protocol = "tcp"
          from_port = 443
          to_port = 443
          cidr_blocks = [local.current_vpc_cidr]
        }
      ]
      egress = [
        {
          protocol = "-1"
          from_port = 0
          to_port = 0
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }
}

resource "aws_security_group" "sg" {
  for_each = local.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = var.alpha.vpc.id

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      description = "Ingress ${ingress.value.protocol} ${ingress.value.from_port}-${ingress.value.to_port} from ${join(", ", ingress.value.cidr_blocks)}"
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = each.value.egress
    content {
      description = "Egress ${egress.value.protocol} ${egress.value.from_port}-${egress.value.to_port} to ${join(", ", egress.value.cidr_blocks)}"
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge(var.alpha.tags, {
    Name = each.value.name
  })
}
