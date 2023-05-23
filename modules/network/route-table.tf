

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  
  tags = {
    "Name" = "public-route-table"
  }
}


resource "aws_route_table_association" "public-route-association" {
  count = length(var.public-subnets-cidr-blocks)
  subnet_id = aws_subnet.public-subnets[count.index].id 
  route_table_id = aws_route_table.public-route-table.id
}




resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway.id
  }

  
  tags = {
    "Name" = "private-route-table"
  }
}

resource "aws_route_table_association" "private-route-table-association" {
    count = length(var.private-subnets-cidr-blocks)
    subnet_id = aws_subnet.private-subnets[count.index].id
    route_table_id = aws_route_table.private-route-table.id
}



