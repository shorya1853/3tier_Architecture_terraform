module "infra-ap-south-1" {
  source = "./module"
  private_sub_cidr_block = var.private_sub_cidr_block
  public_sub_cidr_block = var.public_sub_cidr_block
}

module "infra-us-east-1" {
  source = "./module"
  private_sub_cidr_block = var.private_sub_cidr_block
  public_sub_cidr_block = var.public_sub_cidr_block

  providers = {
    aws = aws.us-east-1
  }
}

module "infra-us-west-1" {
  source = "./module"
  private_sub_cidr_block = var.private_sub_cidr_block
  public_sub_cidr_block = var.public_sub_cidr_block

  providers = {
    aws = aws.us-west-1
  }
}

output "vpc_id" {
  value =  module.infra-ap-south-1.vpcId
}