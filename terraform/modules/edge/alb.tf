resource "aws_lb" "app" {

  name = "${local.name_prefix}-alb"

  load_balancer_type = "application"

  internal = false

  security_groups = [
    var.alb_security_group_id
  ]

  subnets = var.public_subnet_ids

  enable_deletion_protection = false

  idle_timeout = 60

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-alb"
    }
  )

}