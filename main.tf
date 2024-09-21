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
  count  = length(local.do_we_have_public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.ntier.id
  tags = {
    Name = "ntier-igw"
  }
  depends_on = [ aws_vpc.ntier ]

}
