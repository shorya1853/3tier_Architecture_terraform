resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_sub_cidr_block

  tags = {
    Name = "private-subnet${var.subnet_name}"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_sub_cidr_block

  tags = {
    Name = "public-subnet${var.subnet_name}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.route_table.id
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ec2_instance_type_offerings" "t2_micro" {
  filter {
    name   = "instance-type"
    values = ["t2.micro"]
  }

  filter {
    name   = "location"
    values = data.aws_availability_zones.available.names
  }

  location_type = "availability-zone"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public-subnet.id
  availability_zone = element(data.aws_ec2_instance_type_offerings.t2_micro.locations, 0)

  tags = {
    Name = "public_sub_ec2"
  }
}

resource "aws_instance" "db" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private-subnet.id
  availability_zone = element(data.aws_ec2_instance_type_offerings.t2_micro.locations, 0)

  tags = {
    Name = "private_sub_ec2"
  }
}