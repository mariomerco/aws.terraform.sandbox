resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name" = "${var.project_name}-vpc"
  }
}
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_1
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
}
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_2
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]
}
resource "aws_subnet" "public_subnet_3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_3
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[2]
}
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_1
  availability_zone = data.aws_availability_zones.available.names[0]
}
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_2
  availability_zone = data.aws_availability_zones.available.names[1]
}
resource "aws_subnet" "private_subnet_3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_3
  availability_zone = data.aws_availability_zones.available.names[2]
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-internet-gateway"
  }
}
resource "aws_route_table" "route_to_internet_gateway" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.project_name}-public-route-table"
  }
}

resource "aws_route_table" "route_to_nat_gateway" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.gw.id
  }

  tags = {
    Name = "${var.project_name}-private-route-table"
  }
}
resource "aws_route_table_association" "public_to_internet_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.route_to_internet_gateway.id
}
resource "aws_route_table_association" "public_to_internet_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.route_to_internet_gateway.id
}
resource "aws_route_table_association" "public_to_internet_subnet_3" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.route_to_internet_gateway.id
}

resource "aws_route_table_association" "private_to_nat_subnet_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.route_to_nat_gateway.id
}
resource "aws_route_table_association" "private_to_nat_subnet_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.route_to_nat_gateway.id
}
resource "aws_route_table_association" "private_to_nat_subnet_3" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.route_to_nat_gateway.id
}



### NAT Gateway

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "gw" {
  depends_on = [aws_internet_gateway.gw]

  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "${var.project_name}-nat-gateway"
  }
}


