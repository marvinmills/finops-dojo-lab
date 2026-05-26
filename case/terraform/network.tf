data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.default_tags, {
    Name = "${var.project_name}-vpc"
  })
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = merge(local.default_tags, {
    Name        = "${var.project_name}-public-a"
    Tier        = "public"
    AccountName = "shared-services"
  })
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge(local.default_tags, {
    Name        = "${var.project_name}-private-a"
    Tier        = "data"
    AccountName = "acquired-ai-platform"
  })
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge(local.default_tags, {
    Name        = "${var.project_name}-private-b"
    Tier        = "data"
    AccountName = "legacy-core-prod"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.default_tags, {
    Name = "${var.project_name}-igw"
  })
}

resource "aws_db_subnet_group" "main" {
  name = "${var.project_name}-db-subnets"
  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id,
  ]

  tags = merge(local.default_tags, {
    Name = "${var.project_name}-db-subnet-group"
  })
}

resource "aws_security_group" "db" {
  name        = "${var.project_name}-db-sg"
  description = "Security group for ClarionFlow PostgreSQL"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block] # v1: whole VPC; later tighten to app-tier SG
    description = "PostgreSQL access from within the VPC"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, {
    Name = "${var.project_name}-db-sg"
  })
}