resource "aws_vpc" "vpc" {
  cidr_block           = "10.107.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = false
  instance_tenancy     = "default"

  tags = {
    Name = "massdot"
  }
}

resource "aws_security_group" "rdp" {
  name        = "rdp"
  description = "Allow remote connections to infrastructure"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["10.107.0.0/16", "10.98.0.0/16", "0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.98.0.0/16", "10.107.0.0/16"]
  }

  tags = {
    Name = "rdp"
  }
}

resource "aws_security_group" "www_internal" {
  name        = "www-internal"
  description = "Allows web access to servers"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.107.0.0/16"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.107.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "www-internal"
  }
}
resource "aws_security_group" "db_sql" {
  name        = "db-sql"
  description = "Allows DB access to SQL"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["10.107.0.0/16", "10.98.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.107.0.0/16", "10.98.0.0/16"]
  }

  tags = {
    Name = "db-sql"
  }
}

resource "aws_security_group" "fsx" {
  name        = "fsx"
  description = "FSX Access"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 445
    to_port     = 445
    protocol    = "tcp"
    cidr_blocks = ["10.107.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.107.0.0/16"]
  }

  tags = {
    Name = "fsx"
  }
}

resource "aws_security_group" "db_orcl" {
  name        = "db-orcl"
  description = "Allows DB access to ORACLE"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 1521
    to_port     = 1521
    protocol    = "tcp"
    cidr_blocks = ["10.107.0.0/16", "10.98.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.107.0.0/16", "10.98.0.0/16"]
  }

  tags = {
    Name = "db-orcl"
  }
}

resource "aws_security_group" "www" {
  name        = "www"
  description = "Allow web servers from the internet"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "www"
  }
}
