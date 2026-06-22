#########################################
# Public Network ACL
#########################################

resource "aws_network_acl" "public" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-public-nacl"
    }
  )
}

resource "aws_network_acl_rule" "public_inbound" {

  network_acl_id = aws_network_acl.public.id

  rule_number = 100

  egress = false

  protocol = "-1"

  rule_action = "allow"

  cidr_block = "0.0.0.0/0"

}

resource "aws_network_acl_rule" "public_outbound" {

  network_acl_id = aws_network_acl.public.id

  rule_number = 100

  egress = true

  protocol = "-1"

  rule_action = "allow"

  cidr_block = "0.0.0.0/0"

}

resource "aws_network_acl_association" "public" {

  for_each = {
    for key, subnet in var.subnets :
    key => subnet
    if subnet.type == "public"
  }

  subnet_id = aws_subnet.subnets[each.key].id

  network_acl_id = aws_network_acl.public.id

}

#########################################
# Private Network ACL
#########################################

resource "aws_network_acl" "private" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-private-nacl"
    }
  )
}

resource "aws_network_acl_rule" "private_inbound" {

  network_acl_id = aws_network_acl.private.id

  rule_number = 100

  egress = false

  protocol = "-1"

  rule_action = "allow"

  cidr_block = "0.0.0.0/0"

}

resource "aws_network_acl_rule" "private_outbound" {

  network_acl_id = aws_network_acl.private.id

  rule_number = 100

  egress = true

  protocol = "-1"

  rule_action = "allow"

  cidr_block = "0.0.0.0/0"

}

resource "aws_network_acl_association" "private" {

  for_each = {
    for key, subnet in var.subnets :
    key => subnet
    if subnet.type != "public"
  }

  subnet_id = aws_subnet.subnets[each.key].id

  network_acl_id = aws_network_acl.private.id

}
