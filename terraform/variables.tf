variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "aws-swa-prod"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}