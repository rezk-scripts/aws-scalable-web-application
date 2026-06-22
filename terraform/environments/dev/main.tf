module "network" {

  source = "../../modules/network"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region
  
  vpc_cidr = var.vpc_cidr
  subnets  = var.subnets


}