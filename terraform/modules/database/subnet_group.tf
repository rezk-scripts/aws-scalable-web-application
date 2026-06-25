resource "aws_db_subnet_group" "main" {

  name        = "${local.name_prefix}-db-subnet-group"
  description = "Subnet group for PostgreSQL database"
  subnet_ids  = var.private_db_subnet_ids

  tags = merge(

    local.common_tags,

    {

      Name = "${local.name_prefix}-db-subnet-group"

    }

  )

}
