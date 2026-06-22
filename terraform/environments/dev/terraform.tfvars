project_name = "swa"
environment  = "dev"
aws_region   = "eu-north-1"

###################################
# VPC and Subnets
###################################

vpc_cidr = "10.0.0.0/16"

subnets = {

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