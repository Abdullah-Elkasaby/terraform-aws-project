
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc-cidr
    tags = var.vpc-tags
    
    
  
}


resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id
    tags = var.igw-tags
    
}


