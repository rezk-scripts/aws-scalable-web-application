resource "aws_db_parameter_group" "postgres" {

  name = "${local.name_prefix}-postgres"
  family = "postgres17"
  description = "custom parameter group for PostgreSQL"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-postgres-parameter-group"
    }
  )

}