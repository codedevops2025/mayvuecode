locals {
  public_subnets = [
    "public-nat-2a", "public-nat-2b", "public-nat-2c",
    "public-lb-2a", "public-lb-2b", "public-lb-2c"
  ]

  private_subnets = [
    "private-ad-2a", "private-ad-2b", "private-ad-2c",
    "private-apps-2a", "private-apps-2b", "private-apps-2c",
    "private-tgwy-2a", "private-tgwy-2b", "private-tgwy-2c"
  ]

  vpn_subnets = [
    "private-db-2a", "private-db-2b", "private-db-2c",
    "private-fs-2a", "private-fs-2b", "private-fs-2c"
  ]
}

data "aws_ec2_transit_gateway" "shared" {
  filter {
    name   = "tag:Name"
    values = ["brm-sandbox-tgw"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

data "aws_internet_gateway" "igw" {
  filter {
    name   = "attachment.vpc-id"
    values = [var.config.vpc.id]
  }
}

data "aws_subnet" "public_nat_2a" {
  filter {
    name   = "tag:Name"
    values = ["public-nat-2a"]
  }

  filter {
    name   = "vpc-id"
    values = [var.config.vpc.id]
  }
}

data "aws_nat_gateway" "nat" {
  filter {
    name   = "vpc-id"
    values = [var.config.vpc.id]
  }

  filter {
    name   = "subnet-id"
    values = [data.aws_subnet.public_nat_2a.id]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  depends_on = [data.aws_subnet.public_nat_2a]
}

data "aws_subnet" "all" {
  for_each = toset(var.config.subnets)

  filter {
    name   = "tag:Name"
    values = [each.value]
  }

  filter {
    name   = "vpc-id"
    values = [var.config.vpc.id]
  }
}

# Group private subnets by AZ and pick one per AZ for TGW
locals {
  private_subnet_objects = [
    for name, subnet in data.aws_subnet.all :
    {
      name      = name
      id        = subnet.id
      az        = subnet.availability_zone
    }
    if contains(local.private_subnets, name)
  ]

  # Create a map of az => list of subnet objects
  az_to_subnet_ids = {
    for az in distinct([for s in local.private_subnet_objects : s.az]) :
    az => [
      for s in local.private_subnet_objects : s.id if s.az == az
    ]
  }

  # Get one subnet per AZ
  tgw_subnets = [
    for az in keys(local.az_to_subnet_ids) :
    local.az_to_subnet_ids[az][0]
  ]
}





resource "aws_ec2_transit_gateway_vpc_attachment" "attachment" {
  subnet_ids         = local.tgw_subnets
  transit_gateway_id = data.aws_ec2_transit_gateway.shared.id
  vpc_id             = var.config.vpc.id

  tags = merge(var.config.tags, {
    Name = format("%s-%s-tgwy-attachement",var.config.tags["env"],var.config.tags["project"])

  })
}

# --- Public Route Table ---
resource "aws_route_table" "rt_public" {
  vpc_id = var.config.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.igw.id
  }

  tags = merge(var.config.tags, {
    Name = format("%s-%s-rt-public", var.config.tags["env"], var.config.tags["project"])
  })
}

resource "aws_route_table_association" "rt_public_assocs" {
  for_each = {
    for name, subnet in data.aws_subnet.all : name => subnet
    if contains(local.public_subnets, name)
  }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt_public.id
}

# --- Private Route Table ---
resource "aws_route_table" "rt_private" {
  vpc_id = var.config.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = data.aws_nat_gateway.nat.id
  }

  tags = merge(var.config.tags, {
    Name = format("%s-%s-rt-private", var.config.tags["env"], var.config.tags["project"])
  })
}

resource "aws_route" "rt_private_to_tgw" {
  route_table_id         = aws_route_table.rt_private.id
  destination_cidr_block = var.config.routes.infra_cidr_block
  transit_gateway_id     = data.aws_ec2_transit_gateway.shared.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.attachment]
}

resource "aws_route_table_association" "rt_private_assocs" {
  for_each = {
    for name, subnet in data.aws_subnet.all : name => subnet
    if contains(local.private_subnets, name)
  }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt_private.id
}

# --- VPN Route Table ---
resource "aws_route_table" "rt_vpn" {
  vpc_id = var.config.vpc.id

  tags = merge(var.config.tags, {
    Name = format("%s-%s-rt-vpn", var.config.tags["env"], var.config.tags["project"])
  })
}

resource "aws_route" "rt_vpn_to_tgw" {
  route_table_id         = aws_route_table.rt_vpn.id
  destination_cidr_block = var.config.routes.infra_cidr_block
  transit_gateway_id     = data.aws_ec2_transit_gateway.shared.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.attachment]
}

resource "aws_route_table_association" "rt_vpn_assocs" {
  for_each = {
    for name, subnet in data.aws_subnet.all : name => subnet
    if contains(local.vpn_subnets, name)
  }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt_vpn.id
}
