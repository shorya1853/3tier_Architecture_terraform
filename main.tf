module "infra-ap-south-1" {
  source = "./module"
  private_sub_cidr_block = var.private_sub_cidr_block
  public_sub_cidr_block = var.public_sub_cidr_block
  vpc_name = "ap-south-1"
  subnet_name = "ap-south-1"
}

module "infra-us-east-1" {
  source = "./module"
  private_sub_cidr_block = var.private_sub_cidr_block
  public_sub_cidr_block = var.public_sub_cidr_block
vpc_name = "us-east-1"
  subnet_name = "us-east-1"
  providers = {
    aws = aws.us-east-1
  }
}

module "infra-us-west-1" {
  source = "./module"
  private_sub_cidr_block = var.private_sub_cidr_block
  public_sub_cidr_block = var.public_sub_cidr_block
  vpc_name = "us-west-1"
  subnet_name = "us-west-1"
  providers = {
    aws = aws.us-west-1
  }
}

output "vpc_id" {
  value =  module.infra-ap-south-1.vpcId
}

output "private_sub_ec2-ap-south-1" {
  value = module.infra-ap-south-1.private_sub_ec2
}
output "private_sub_ec2-us-west-1" {
  value = module.infra-us-west-1.private_sub_ec2
}
output "private_sub_ec2-us-east-1" {
  value = module.infra-us-east-1.private_sub_ec2
}
output "public_sub_ec2-ap-south-1" {
  value = module.infra-ap-south-1.public_sub_ec2
}
output "public_sub_ec2-us-west-1" {
  value = module.infra-us-west-1.public_sub_ec2
}
output "public_sub_ec2-us-east-1" {
  value = module.infra-us-east-1.public_sub_ec2
}

