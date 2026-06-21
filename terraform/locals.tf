locals {

  common_tags = {
    Project     = "aws-saa-prod"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "Rezk"
  }

}