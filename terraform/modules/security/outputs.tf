output "alb_security_group_id" {
  description = "Security Group ID for the ALB"
  value       = aws_security_group.alb.id
}

output "app_security_group_id" {
  description = "Security Group ID for EC2 instances"
  value       = aws_security_group.app.id
}

output "db_security_group_id" {
  description = "Security Group ID for the database"
  value       = aws_security_group.database.id
}

output "instance_profile_name" {

  description = "IAM Instance Profile for EC2"

  value = aws_iam_instance_profile.ec2.name

}

output "ec2_role_arn" {

  description = "IAM Role ARN"

  value = aws_iam_role.ec2.arn

}

output "vpc_endpoint_security_group_id" {

  description = "Security Group for Interface VPC Endpoints"

  value = aws_security_group.vpce.id

}