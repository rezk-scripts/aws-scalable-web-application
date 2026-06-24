output "ami_id" {
  description = "Latest Amazon Linux 2023 AMI ID"
  value       = data.aws_ami.amazon_linux.id
}
output "autoscaling_group_name" {

  value = aws_autoscaling_group.app.name

}
output "launch_template_id" {

  value = aws_launch_template.app.id

}

output "autoscaling_group_arn" {
  value = aws_autoscaling_group.app.arn
}

output "launch_template_latest_version" {
  value = aws_launch_template.app.latest_version
}