terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}

#aws vpc
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/22"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "main",
    Project     = "ecs-v1",
    Environment = "dev"

  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/25"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "public-a"
    Project     = "ecs-v1"
    Environment = "dev"
  }

}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.128/25"
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "public-b"
    Project     = "ecs-v1"
    Environment = "dev"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "igw"
    Project     = "ecs-v1"
    Environment = "dev"
  }

}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "public-rt"
    Project     = "ecs-v1"
    Environment = "dev"
  }
}


resource "aws_route_table_association" "public_a_association" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id

}

resource "aws_route_table_association" "public_b_association" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id

}

resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/25"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = false

  tags = {
    Name        = "private-a"
    Project     = "ecs-v1"
    Environment = "dev"
  }

}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.128/25"
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = false

  tags = {
    Name        = "private-b"
    Project     = "ecs-v1"
    Environment = "dev"
  }

}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "private-rt"
    Project     = "ecs-v1"
    Environment = "dev"
  }
}

resource "aws_route_table_association" "private_a_association" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_b_association" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_rt.id
}
