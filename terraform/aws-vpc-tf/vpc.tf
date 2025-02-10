
### Let’s begin by defining our VPC resource in Terraform. To specify the range of IP addresses within the VPC, we need to provide a CIDR block. Additionally, we’ve included a Name tag for easier identification.

### Step 1 : create  VPC 
resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "portfolio-vpc"
  }
}

### Step 2 : Create public subnet inside the VPC 
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet"
  }
}

### Step 3 : Create private subnet inside the VPC 
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Private-Subnet"
  }
}

### Step 4 : Set up an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "VPC-IG"
  }
}

### Step 5 : Create a Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Internet-Route-Table"
  }
}

### Step 6 : Associate Public Subnets with the Route Table
resource "aws_route_table_association" "rt_a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt.id
}