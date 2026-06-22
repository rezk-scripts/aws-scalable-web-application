variable "aws_region" {
  type        = string
}

variable "project_name" {
  type        = string
}

variable "environment" {
  type        = string
}

#########################################
# VPC
#########################################

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

#########################################
# Subnets
#########################################

variable "subnets" {
  description = "Subnet definitions"
  type = map(object({

    cidr = string
    az   = string
    type = string

  }))
  }

