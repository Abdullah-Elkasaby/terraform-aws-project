

resource "aws_eip" "elastic-ip" {
  vpc = true
  
  depends_on = [aws_internet_gateway.internet_gateway]
}


resource "aws_nat_gateway" "nat-gateway" {
  
  allocation_id = aws_eip.elastic-ip.id
  subnet_id     = aws_subnet.public-subnets[0].id

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gateway, aws_eip.elastic-ip, aws_subnet.public-subnets]
}