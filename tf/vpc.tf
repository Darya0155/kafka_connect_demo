
resource "aws_vpc" "aws_mks_connect_demo_VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  tags = {
    Name = "aws_mks_connect_demo_VPC"
  }
  enable_dns_hostnames = true

}

resource "aws_subnet" "aws_mks_connect_demo_subnet_private_1" {
  vpc_id     = aws_vpc.aws_mks_connect_demo_VPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "aws_mks_connect_demo_subnet_private_1"
  }
}

resource "aws_subnet" "aws_mks_connect_demo_subnet_private_2" {
  vpc_id     = aws_vpc.aws_mks_connect_demo_VPC.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "aws_mks_connect_demo_subnet_private_2"
  }
}

resource "aws_subnet" "aws_mks_connect_demo_subnet_public_2" {
  vpc_id     = aws_vpc.aws_mks_connect_demo_VPC.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "aws_mks_connect_demo_subnet_public_2"
  }
}

resource "aws_subnet" "aws_mks_connect_demo_subnet_public_1" {
  vpc_id     = aws_vpc.aws_mks_connect_demo_VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "aws_mks_connect_demo_subnet_public_1"
  }
}

resource "aws_eip" "aws_mks_connect_demo_eip" {

}

resource "aws_nat_gateway" "aws_mks_connect_demo_nat_gateway" {
  allocation_id = aws_eip.aws_mks_connect_demo_eip.id
  subnet_id     = aws_subnet.aws_mks_connect_demo_subnet_public_2.id

  tags = {
    Name = "aws_mks_connect_demo_nat_gateway"
  }
  depends_on = [aws_route.aws_mks_connect_demo_default_routetable,aws_eip.aws_mks_connect_demo_eip  ]
}

resource "aws_internet_gateway" "aws_mks_connect_demo_gateway" {
  vpc_id = aws_vpc.aws_mks_connect_demo_VPC.id

  tags = {
    Name = "main_gw"
  }

}

# resource "aws_internet_gateway_attachment" "gw_attachment" {
#   internet_gateway_id = aws_internet_gateway.gw.id
#   vpc_id              = aws_vpc.main_vpc.id
# }

resource "aws_route_table" "aws_mks_connect_demo_route_table_private" {
  vpc_id = aws_vpc.aws_mks_connect_demo_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.aws_mks_connect_demo_nat_gateway.id
  }

  tags = {
    Name = "route_table_private"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.aws_mks_connect_demo_subnet_private_2.id
  route_table_id = aws_route_table.aws_mks_connect_demo_route_table_private.id
}
resource "aws_route_table_association" "B" {
  subnet_id      = aws_subnet.aws_mks_connect_demo_subnet_private_1.id
  route_table_id = aws_route_table.aws_mks_connect_demo_route_table_private.id
}



resource "aws_route" "aws_mks_connect_demo_default_routetable" {
  route_table_id            = aws_vpc.aws_mks_connect_demo_VPC.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.aws_mks_connect_demo_gateway.id
}