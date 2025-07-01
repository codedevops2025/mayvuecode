resource "aws_security_group" "rdp" {
  name        = "rdp"
  description = "Allow remote connections to infrastructure"
  vpc_id      = "vpc-0bfc335c635edbb74"

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
    cidr_blocks = ["10.107.0.0/16", "10.98.0.0/16"]
  }

  tags = {
    Name = "rdp"
  }
}

resource "aws_security_group" "www_internal" {
  name        = "www-internal"
  description = "Allows web access to servers"
  vpc_id      = "vpc-0bfc335c635edbb74"

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
  vpc_id      = "vpc-0bfc335c635edbb74"

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
  vpc_id      = "vpc-0bfc335c635edbb74"

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
  vpc_id      = "vpc-0bfc335c635edbb74"

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
  vpc_id      = "vpc-0bfc335c635edbb74"

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


    # { name = "public-lb-2a",   cidr = "10.107.3.0/26",        az = "us-east-2a" },
    # { name = "public-lb-2b",   cidr = "10.107.3.64/26",       az = "us-east-2b" },
       # { name = "private-db-2a",  cidr = "10.107.2.0/28",        az = "us-east-2a" },
      # { name = "private-db-2a",  cidr = "10.107.2.0/28",        az = "us-east-2a" },   
          # { name = "private-ad-2a",  cidr = "10.107.2.48/28",       az = "us-east-2a" },
              # { name = "public-nat-2a",  cidr = "10.107.0.32/28",       az = "us-east-2a" },
                  # { name = "public-nat-2c",  cidr = "10.107.0.64/28",       az = "us-east-2c" },