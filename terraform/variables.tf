variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "eu-north-1"
}

variable "aws_profile" {
  description = "AWS profile"
  type        = string
  default     = "arezk"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "swa"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

#########################################
# Network
#########################################

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
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

  default = {

    public_a = {
      cidr = "10.0.1.0/24"
      az   = "eu-north-1a"
      type = "public"
    }

    public_b = {
      cidr = "10.0.2.0/24"
      az   = "eu-north-1b"
      type = "public"
    }

    private_app_a = {
      cidr = "10.0.11.0/24"
      az   = "eu-north-1a"
      type = "private-app"
    }

    private_app_b = {
      cidr = "10.0.12.0/24"
      az   = "eu-north-1b"
      type = "private-app"
    }

    private_db_a = {
      cidr = "10.0.21.0/24"
      az   = "eu-north-1a"
      type = "private-db"
    }

    private_db_b = {
      cidr = "10.0.22.0/24"
      az   = "eu-north-1b"
      type = "private-db"
    }

  }

}
