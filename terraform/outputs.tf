#########################################
# VPC Outputs
#########################################

output "vpc_id" {
  description = "The ID of the VPC"

  value = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "The VPC CIDR block"

  value = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {

  value = [

    for subnet in aws_subnet.subnets :

    subnet.id

    if subnet.map_public_ip_on_launch

  ]

}

output "private_subnet_ids" {

  value = [

    for subnet in aws_subnet.subnets :

    subnet.id

    if !subnet.map_public_ip_on_launch

  ]

}

output "internet_gateway_id" {
  description = "Internet Gateway ID"

  value = aws_internet_gateway.main.id
}

output "public_route_table_id" {
  description = "Public route table ID"

  value = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "Private route table ID"

  value = aws_route_table.private.id
}