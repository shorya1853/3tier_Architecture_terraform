output "vpc-ap-south-1Id" {
  value = module.vpc-ap-south-1.private_subnet_arns
}
output "ap_south_1a_private_subnet" {
  value = module.vpc-ap-south-1.private_subnets[0]
}

output "ap_south_1b_private_subnet" {
  value = module.vpc-ap-south-1.private_subnets[1]
}
output "route_table_ids" {
  value = module.vpc-ap-south-1.private_route_table_ids
}
