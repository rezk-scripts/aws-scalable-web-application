variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

################################
# Network Variables
################################
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "Subnet configuration"

  type = map(object({
    cidr = string
    az   = string
    type = string
  }))
}


###############################
# Compute Variables
###############################

variable "instance_type" {
  type = string
}

variable "root_volume_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}

variable "max_size" {
  type = number
}

################################
# Database Variables
################################

variable "db_backup_retention_period" {
  type = number
}
variable "db_instance_class" {

  type = string

}

variable "db_allocated_storage" {

  type = number

}
variable "db_username" {

  type = string

}

variable "db_password" {

  type = string

  sensitive = true

}