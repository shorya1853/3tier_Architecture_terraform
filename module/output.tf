output "vpcId" {
  value = aws_vpc.main.id
}
output "private_sub_ec2" {
  value = aws_instance.db.id
}
output "public_sub_ec2" {
  value = aws_instance.web.id
}
output "gateway_id" {
  value = aws_internet_gateway.gw.id
  
}

