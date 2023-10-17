resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name" = "${var.project_name}-vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = var.public_subnets_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = count.index > 3 ? data.aws_availability_zones.available.names[count.index - 3] : data.aws_availability_zones.available.names[count.index]
  # If number count.index is greater than 3, substract 3 from it. This way we asure we just use 3 AZs. If the region doesn't have more, then it won't fail
}

resource "aws_subnet" "private_subnets" {
  count             = var.private_subnets_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, count.index + var.public_subnets_count)
  availability_zone = count.index > 3 ? data.aws_availability_zones.available.names[count.index - 3] : data.aws_availability_zones.available.names[count.index]
  # If number count.index is greater than 3, substract 3 from it. This way we asure we just use 3 AZs. If the region doesn't have more, then it won't fail
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

resource "aws_route_table_association" "public_to_internet_subnets" {
  count          = var.public_subnets_count
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.route_to_internet_gateway.id
}

resource "aws_route_table_association" "private_to_nat_subnets" {
  count          = var.private_subnets_count
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.route_to_nat_gateway.id
}

### NAT Gateway

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "gw" {
  depends_on = [aws_internet_gateway.gw]

  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${var.project_name}-nat-gateway"
  }
}


