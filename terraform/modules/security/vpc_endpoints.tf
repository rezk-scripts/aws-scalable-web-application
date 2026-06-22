locals {

  ssm_endpoints = [
    "ssm",
    "ssmmessages",
    "ec2messages"
  ]

}

resource "aws_vpc_endpoint" "ssm" {

  for_each = toset(local.ssm_endpoints)

  vpc_id = var.vpc_id

  service_name = "com.amazonaws.${var.aws_region}.${each.value}"

  vpc_endpoint_type = "Interface"

  subnet_ids = var.private_app_subnet_ids

  security_group_ids = [
    aws_security_group.vpce.id
  ]

  private_dns_enabled = true

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-${each.value}-endpoint"
    }
  )

}