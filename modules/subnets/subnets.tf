locals {
  azs = ["us-east-2a", "us-east-2b", "us-east-2c"]

  base_octets = split(".", var.alpha.vpc.cidr)
  A           = local.base_octets[0]
  B           = local.base_octets[1]
  C           = tonumber(local.base_octets[2])
  netmask     = tonumber(regex("\\/(\\d+)$", var.alpha.vpc.cidr)[0])

  subnet_layouts = local.netmask == 16 ? [
    {
      name   = "public-nat"
      base   = 0
      mask   = 28
      offsets = [32, 48, 64]
    },
    {
      name   = "private-db"
      base   = 2
      mask   = 28
      offsets = [0, 16, 32]
    },
    {
      name   = "private-ad"
      base   = 2
      mask   = 28
      offsets = [48, 64, 80]
    },
    {
      name   = "private-fs"
      base   = 2
      mask   = 28
      offsets = [96, 112, 128]
    },
    {
      name   = "public-lb"
      base   = 3
      mask   = 26
      offsets = [0, 64, 128]
    },
    {
      name   = "private-apps"
      base   = 4
      mask   = 26
      offsets = [0, 64, 128]
    },
    {
      name   = "private-tgwy"
      base   = 255
      mask   = 28
      offsets = [208, 224, 240]
    }
  ] : [
    {
      name   = "public-nat"
      base   = local.C + 0
      mask   = 28
      offsets = [16, 32, 48]
    },
    {
      name   = "public-lb"
      base   = local.C + 0
      mask   = 26
      offsets = [64, 128, 192]
    },
    {
      name   = "private-apps"
      base   = local.C + 1
      mask   = 26
      offsets = [0, 64, 128]
    },
    {
      name   = "private-db"
      base   = local.C + 2
      mask   = 28
      offsets = [0, 16, 32]
    },
    {
      name   = "private-ad"
      base   = local.C + 2
      mask   = 28
      offsets = [48, 64, 80]
    },
    {
      name   = "private-fs"
      base   = local.C + 2
      mask   = 28
      offsets = [96, 112, 128]
    },
    {
      name   = "private-tgwy"
      base   = local.C + 3
      mask   = 28
      offsets = [208, 224, 240]
    }
  ]

  all_subnets = flatten([
    for layout in local.subnet_layouts : [
      for i in range(3) : {
        name       = "${layout.name}-2${substr(local.azs[i], -1, 1)}"
        az         = local.azs[i]
        cidr_block = format("%s.%s.%s.%s/%s",
          local.A,
          local.B,
          layout.base,
          layout.offsets[i],
          layout.mask
        )
      }
    ]
  ])

  subnets = [
    for subnet in local.all_subnets : subnet
    if contains(var.alpha.subnets, subnet.name)
  ]
}

resource "aws_subnet" "generated" {
  for_each = { for subnet in local.subnets : subnet.name => subnet }

  vpc_id                  = var.alpha.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = false

  tags = merge(var.alpha.tags, {
    Name = each.value.name
  })
}

output "public_nat_2a_id" {
  value = aws_subnet.generated["public-nat-2a"].id
}

