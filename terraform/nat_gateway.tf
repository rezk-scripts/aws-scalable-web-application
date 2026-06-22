#########################################
# Elastic IP
#########################################

resource "aws_eip" "nat" {

  domain = "vpc"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-nat-eip"
    }
  )
}

#########################################
# NAT Gateway
#########################################

resource "aws_nat_gateway" "main" {

  allocation_id = aws_eip.nat.id

  subnet_id = aws_subnet.subnets["public_a"].id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-nat-gateway"
    }
  )

  depends_on = [
    aws_internet_gateway.main
  ]
}