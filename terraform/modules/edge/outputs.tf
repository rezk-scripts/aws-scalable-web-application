output "target_group_arn" {

  description = "Application Target Group ARN"

  value = aws_lb_target_group.app.arn

}

output "alb_dns_name" {

  description = "Application Load Balancer DNS"

  value = aws_lb.app.dns_name

}

output "alb_zone_id" {

  description = "Hosted Zone ID"

  value = aws_lb.app.zone_id

}