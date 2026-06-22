#########################################
# Public Route Table
#########################################

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.main.id

  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-public-rt"
    }
  )
}

#########################################
# Public Route Table Associations
#########################################

resource "aws_route_table_association" "public" {

  for_each = {

    for key, subnet in var.subnets :

    key => subnet

    if subnet.type == "public"

  }

  subnet_id = aws_subnet.subnets[each.key].id

  route_table_id = aws_route_table.public.id

}

#########################################
# Private Route Table
#########################################

resource "aws_route_table" "private" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.main.id

  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-private-rt"
    }
  )
}


#########################################
# Private Route Table Associations
#########################################

resource "aws_route_table_association" "private" {

  for_each = {

    for key, subnet in var.subnets :

    key => subnet

    if subnet.type != "public"

  }

  subnet_id = aws_subnet.subnets[each.key].id

  route_table_id = aws_route_table.private.id

}