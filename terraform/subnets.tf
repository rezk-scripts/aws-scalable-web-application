#########################################
# Subnets
#########################################

resource "aws_subnet" "subnets" {

  for_each = var.subnets

  vpc_id = aws_vpc.main.id

  cidr_block = each.value.cidr

  availability_zone = each.value.az

  map_public_ip_on_launch = each.value.type == "public"

  tags = merge(

    local.common_tags,

    {

      Name = "${local.name_prefix}-${replace(each.key, "_", "-")}"

      Type = each.value.type

    }

  )

}