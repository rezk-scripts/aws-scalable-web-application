variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_db_subnet_ids" {
  type = list(string)
}

variable "database_security_group_id" {
  type = string
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true

}

variable "allocated_storage" {
  type    = number

}

variable "instance_class" {
  type    = string
}

variable "backup_retention_period" {
  type    = number

}