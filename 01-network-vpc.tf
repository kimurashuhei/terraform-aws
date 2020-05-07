resource "aws_vpc" "tf-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.resource_prefix}-vpc"
  }
}

resource "aws_internet_gateway" "tf-internet-gateway" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    Name = "${var.resource_prefix}-igw"
  }
}

resource "aws_route_table" "tf-public" {
  vpc_id       = aws_vpc.tf-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-internet-gateway.id
  }
  tags = {
    Name = "${var.resource_prefix}-rtb"
  }
}

resource "aws_subnet" "tf-subnet-1a" {
  count                   = 1
  vpc_id                  = aws_vpc.tf-vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  depends_on = [aws_internet_gateway.tf-internet-gateway]
  tags = {
    Name = "${var.resource_prefix}-subnet-1a"
  }
}

resource "aws_subnet" "tf-subnet-1c" {
  count                   = 1
  vpc_id                  = aws_vpc.tf-vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  depends_on = [aws_internet_gateway.tf-internet-gateway]
  tags = {
    Name = "${var.resource_prefix}-subnet-1c"
  }
}

resource "aws_route_table_association" "tf-rtb-association-subnet-1a" {
  count          = length(aws_subnet.tf-subnet-1a)
  subnet_id      = aws_subnet.tf-subnet-1a[count.index].id
  route_table_id = aws_route_table.tf-public.id
}

resource "aws_route_table_association" "tf-rtb-association-subnet-1c" {
  count          = length(aws_subnet.tf-subnet-1c)
  subnet_id      = aws_subnet.tf-subnet-1c[count.index].id
  route_table_id = aws_route_table.tf-public.id
}
