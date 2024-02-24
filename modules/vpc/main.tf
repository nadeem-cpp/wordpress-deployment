resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    "Name" = "my_vpc"
  }
}

resource "aws_subnet" "my_public_subnet_1" {
  availability_zone       = var.availability_zones[0]
  vpc_id                  = aws_vpc.my_vpc.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.1.0/24"
  tags = {
    "Name" = "public_subnet_1"
  }
}

resource "aws_subnet" "my_public_subnet_2" {
  availability_zone       = var.availability_zones[1]
  vpc_id                  = aws_vpc.my_vpc.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.2.0/24"
  tags = {
    "Name" = "public_subnet_2"
  }
}

resource "aws_subnet" "my_private_subnet_1" {
  availability_zone       = var.availability_zones[0]
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.my_vpc.id
  tags = {
    "Name" = "private_subnet_1"
  }
}
resource "aws_subnet" "my_private_subnet_2" {
  availability_zone       = var.availability_zones[1]
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.my_vpc.id
  tags = {
    "Name" = "private_subnet_2"
  }
}
resource "aws_subnet" "my_private_subnet_3" {
  availability_zone       = var.availability_zones[2]
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.my_vpc.id
  tags = {
    "Name" = "private_subnet_3"
  }
}

resource "aws_internet_gateway" "my_gateway" {
}

resource "aws_internet_gateway_attachment" "my_gateway_connection" {
  vpc_id              = aws_vpc.my_vpc.id
  internet_gateway_id = aws_internet_gateway.my_gateway.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

}


resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_gateway.id
  #  destination_ipv6_cidr_block = ""
  #  destination_prefix_list_id = ""
}

resource "aws_route_table_association" "public_subnet1_association" {
  route_table_id = aws_route_table.public_route_table.id
  # gateway_id     = aws_internet_gateway.my_gateway.id
  subnet_id = aws_subnet.my_public_subnet_1.id
}

resource "aws_route_table_association" "public_subnet2_association" {
  route_table_id = aws_route_table.public_route_table.id
  # gateway_id     = aws_internet_gateway.my_gateway.id
  subnet_id = aws_subnet.my_public_subnet_2.id
}

resource "aws_eip" "my_elastic_ip" {

}



resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.my_elastic_ip.id
  # nat gateway will be in public subnet so it can talk to internet through internet Gateway
  subnet_id     = aws_subnet.my_public_subnet_2.id
}

# route for default routetable created with vpc
resource "aws_route" "default_route" {
  route_table_id         = aws_vpc.my_vpc.default_route_table_id
  nat_gateway_id         = aws_nat_gateway.my_nat.id
  destination_cidr_block = "0.0.0.0/0"
}
