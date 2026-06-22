module "network" {

  source = "../../modules/network"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  vpc_cidr = var.vpc_cidr
  subnets  = var.subnets


}

module "security" {

  source = "../../modules/security"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  vpc_id = module.network.vpc_id

  private_app_subnet_ids = module.network.private_app_subnet_ids

}

module "compute" {

  source = "../../modules/compute"

  project_name = var.project_name
  environment  = var.environment

  private_app_subnet_ids = module.network.private_app_subnet_ids

  app_security_group_id = module.security.app_security_group_id

  instance_profile_name = module.security.instance_profile_name

}