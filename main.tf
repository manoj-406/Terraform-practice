#create vpc
resource "aws_vpc" "ntier" {
  cidr_block           = var.vpc_info.cidr_block
  tags                 = var.vpc_info.tags
  enable_dns_hostnames = var.vpc_info.enable_dns_hostnames

}

#create public subnets
resource "aws_subnet" "public" {
  count             = length(var.public_subnet)
  vpc_id            = aws_vpc.ntier.id
  cidr_block        = var.public_subnet[count.index].cidr_block
  availability_zone = var.public_subnet[count.index].availability_zone
  tags              = var.public_subnet[count.index].tags
  depends_on        = [var.vpc_info]

}

#create private subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnet)
  vpc_id            = aws_vpc.ntier.id
  cidr_block        = var.private_subnet[count.index].cidr_block
  availability_zone = var.private_subnet[count.index].availability_zone
  tags              = var.private_subnet[count.index].tags
  depends_on        = [var.vpc_info]

}

#create igw
resource "aws_internet_gateway" "ntier" {
  count  = local.do_we_have_public_subnets ? 1 : 0
  vpc_id = aws_vpc.ntier.id
  tags = {
    Name = "ntier-igw"
  }
  depends_on = [aws_vpc.ntier]

}

#create public route table

resource "aws_route_table" "public" {
  count  = local.do_we_have_public_subnets ? 1 : 0
  vpc_id = aws_vpc.ntier.id
  tags = {
    Name = "public-RT"
  }
  depends_on = [aws_vpc.ntier]
}

#add routetable associations for public

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet)
  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public[count.index].id
  depends_on     = [aws_route_table.public, aws_subnet.public]

}

#create private route table

resource "aws_route_table" "private" {
  count  = local.do_we_have_private_subnets ? 1 : 0
  vpc_id = aws_vpc.ntier.id
  tags = {
    Name = "private-RT"
  }
  depends_on = [aws_vpc.ntier]
}

#add routetable associations for private

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet)
  route_table_id = aws_route_table.private[0].id
  subnet_id      = aws_subnet.private[count.index].id
  depends_on     = [aws_route_table.private, aws_subnet.private]

}
