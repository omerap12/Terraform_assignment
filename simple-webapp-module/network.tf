# Define the VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "terraform-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  count             = length(var.public_subnet_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zone

  map_public_ip_on_launch = true # This enables auto-assign public IPs to instances in this subnet

  tags = {
    Name = "terraform-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private-subnet" {
  count             = length(var.private_subnet_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zone

  tags = {
    Name = "terraform-private-subnet-${count.index + 1}"
  }
}

