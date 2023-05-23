

resource "aws_subnet" "public-subnets" {
    vpc_id = aws_vpc.vpc.id
    count = length(var.public-subnets-cidr-blocks)
    cidr_block = var.public-subnets-cidr-blocks[count.index]
    map_public_ip_on_launch = true
    availability_zone = var.zones[count.index % length(var.zones)]
    
}

resource "aws_subnet" "private-subnets" {
    count = length(var.private-subnets-cidr-blocks)
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private-subnets-cidr-blocks[count.index]
    map_public_ip_on_launch = false
    availability_zone = var.zones[count.index % length(var.zones)]

}
