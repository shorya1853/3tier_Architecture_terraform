module "vpc-ap-south-1" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Testing-env"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24", "10.0.104.0/24"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
resource "aws_vpc_endpoint" "s3" {
  tags = {
    "Name": "Testing endpoint"
  }
  vpc_id       = module.vpc-ap-south-1.vpc_id
  service_name = "com.amazonaws.ap-south-1.s3"
}

resource "aws_vpc_endpoint_route_table_association" "endpoint_route_assoc" {
  route_table_id =  module.vpc-ap-south-1.private_route_table_ids
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}



data "aws_s3_bucket" "example" {
  bucket = "saan3"
}

resource "aws_s3_access_point" "s3-access_point" {
  vpc_configuration {
    vpc_id = module.vpc-ap-south-1.vpc_id
  }
  bucket = "saanviaws2"
  name   = "s3accesspoint"


  depends_on = [module.vpc-ap-south-1]
  # VPC must be specified for S3 on Outposts
  
}

# module "us-west-1-vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = "App-env"
#   cidr = "10.0.0.0/16"

#   azs             = ["eu-west-1a", "eu-west-1b"]
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

# azs             = ["ap-south-1a", "ap-south-1b"]
# public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
# private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24", "10.0.104.0/24"]

#   tags = {
#     Terraform = "true"
#     Environment = "dev"
#   }
#   providers = {
#     aws = aws.us-west-1
#   }
# }

