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

module "edge" {

  source = "../../modules/edge"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.network.vpc_id

  public_subnet_ids = module.network.public_subnet_ids

  alb_security_group_id = module.security.alb_security_group_id

}

module "compute" {

  source = "../../modules/compute"

  project_name = var.project_name
  environment  = var.environment

  private_app_subnet_ids = module.network.private_app_subnet_ids
  app_security_group_id  = module.security.app_security_group_id
  instance_profile_name  = module.security.instance_profile_name

  instance_type    = var.instance_type
  root_volume_size = var.root_volume_size

  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  max_size         = var.max_size

  target_group_arn = module.edge.target_group_arn

}

module "database" {

  source = "../../modules/database"

  project_name = var.project_name

  environment = var.environment

  aws_region = var.aws_region

  vpc_id = module.network.vpc_id

  private_db_subnet_ids = module.network.private_db_subnet_ids

  database_security_group_id = module.security.db_security_group_id

  instance_class = var.db_instance_class

  allocated_storage = var.db_allocated_storage

  backup_retention_period = var.db_backup_retention_period

  db_username = var.db_username

  db_password = var.db_password

}