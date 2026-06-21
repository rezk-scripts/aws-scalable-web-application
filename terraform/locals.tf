locals {

  name_prefix = "${var.project_name}-${var.environment}"
  common_tags = {
    Project     = "scalable web application"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "Rezk"
  }

}