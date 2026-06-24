output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "private_app_subnet_ids" {
  value = module.network.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  value = module.network.private_db_subnet_ids
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS"
  value       = module.edge.alb_dns_name
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = module.compute.launch_template_id
}

output "autoscaling_group_name" {
  description = "Auto Scaling Group name"
  value       = module.compute.autoscaling_group_name
}