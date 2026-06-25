resource "aws_db_instance" "postgres" {

  identifier = "${local.name_prefix}-postgres"

  engine = "postgres"

  engine_version = "17"

  instance_class = var.instance_class

  allocated_storage = var.allocated_storage

  storage_type = "gp3"

  storage_encrypted = true

  username = var.db_username

  password = var.db_password

  db_name = var.db_name

  db_subnet_group_name = aws_db_subnet_group.main.name

  vpc_security_group_ids = [

    var.database_security_group_id

  ]

  parameter_group_name = aws_db_parameter_group.postgres.name

  publicly_accessible = false

  multi_az = true

  backup_retention_period = var.backup_retention_period

  deletion_protection = false

  skip_final_snapshot = true

  auto_minor_version_upgrade = true

  apply_immediately = true

  tags = merge(

    local.common_tags,

    {

      Name = "${local.name_prefix}-postgres"

    }

  )

}