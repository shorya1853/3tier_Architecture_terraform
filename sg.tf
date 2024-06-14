data "aws_vpc" "name" {
  filter {
    name = "tag:Name"
    values = ["project-vpc"]
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.name.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
      
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.name.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}