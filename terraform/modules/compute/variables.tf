variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "private_app_subnet_ids" {
  type = list(string)
}

variable "app_security_group_id" {
  type = string
}

variable "instance_profile_name" {
  type = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
}


##################################
# ASG Variables
##################################

variable "min_size" {
  description = "Minimum number of EC2 instances"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of EC2 instances"
  type        = number
}

##################################
# ALB Variables
##################################

variable "target_group_arn" {
  description = "Target Group ARN for the Application Load Balancer"
  type        = string
}