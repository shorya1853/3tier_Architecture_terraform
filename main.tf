
resource "aws_vpc" "vpc-ap-south-1" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true

  tags = {
    Name = "my-vpc"
  }
}
resource "aws_route_table" "private_route_table" {
  count = 3
  vpc_id = aws_vpc.vpc-ap-south-1.id

  tags = {
    Name = format("private-route-table-%d", count.index)
  }
}

resource "aws_subnet" "private_subnet" {
  count = var.counts
  cidr_block = cidrsubnet(aws_vpc.vpc-ap-south-1.cidr_block, 8, count.index)
  vpc_id     = aws_vpc.vpc-ap-south-1.id
  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]

  tags = {
    Name = format("private-subnet-%d", count.index)
  }
}

resource "aws_route_table_association" "name" {
  count = var.counts
  subnet_id = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index % 3].id
}

resource "aws_vpc_endpoint" "s3" {
  tags = {
    "Name": "Testing endpoint"
  }
  vpc_id       = aws_vpc.vpc-ap-south-1.id
  service_name = var.service_name
}

resource "aws_vpc_endpoint_route_table_association" "endpoint_route_assoc" {
  route_table_id =  aws_route_table.private_route_table[0].id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

resource "aws_s3_access_point" "s3-access_point" {
  vpc_configuration {
    vpc_id = aws_vpc.vpc-ap-south-1.id
  }
  bucket = var.s3_bucket
  name   = "s3accesspoint"


  depends_on = [aws_vpc.vpc-ap-south-1]
  
}
