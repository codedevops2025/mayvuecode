resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(var.infra.tags, {
    Name = format("%s-%s-eip",var.infra.tags["env"],var.infra.tags["project"])
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.infra.vpc.id

  tags = merge(var.infra.tags, {
    Name = format("%s-%s-igw",var.infra.tags["env"],var.infra.tags["project"])
  })
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_nat_2a_id

  tags = merge(var.infra.tags, {
    Name = format("%s-%s-nat",var.infra.tags["env"],var.infra.tags["project"])
  })

  depends_on = [aws_internet_gateway.igw]
}