data "aws_caller_identity" "current" {}

resource "aws_iam_role" "rds_monitoring" {
  count = var.alpha.sql_db.create_monitoring_role ? 1 : 0
  name  = "rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

data "aws_iam_role" "rds_monitoring" {
  count = var.alpha.sql_db.create_monitoring_role ? 0 : 1
  name  = "rds-monitoring-role"
}

resource "aws_iam_role_policy_attachment" "rds_monitoring" {
  count      = var.alpha.sql_db.create_monitoring_role ? 1 : 0
  role       = aws_iam_role.rds_monitoring[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_db_option_group" "this" {
  count                = var.alpha.sql_db.create_option_group ? 1 : 0
  name                 = var.alpha.option_group.name
  engine_name          = var.alpha.option_group.engine_name
  major_engine_version = var.alpha.option_group.major_engine_version

  dynamic "option" {
    for_each = var.alpha.option_group.options
    content {
      option_name                    = option.value.option_name
      port                           = lookup(option.value, "port", null)
      vpc_security_group_memberships = lookup(option.value, "vpc_security_group_memberships", null)
    }
  }

  tags = var.alpha.option_group.tags
}

locals {
  monitoring_role_arn = var.alpha.sql_db.create_monitoring_role ? aws_iam_role.rds_monitoring[0].arn : data.aws_iam_role.rds_monitoring[0].arn
  option_group_name   = var.alpha.sql_db.create_option_group   ? aws_db_option_group.this[0].name     : var.alpha.sql_db.option_group_name
}



resource "aws_db_instance" "this" {
  identifier                            = var.alpha.sql_db.db_identifier
  instance_class                        = var.alpha.sql_db.db_instance_class
  engine                                = var.alpha.sql_db.engine
  username                              = var.alpha.sql_db.username
  password                              = var.alpha.sql_db.password
  allocated_storage                     = var.alpha.sql_db.allocated_storage
  iops                                  = var.alpha.sql_db.iops
  multi_az                              = var.alpha.sql_db.multi_az
  publicly_accessible                   = var.alpha.sql_db.publicly_accessible
  option_group_name                     = local.option_group_name
  parameter_group_name                  = var.alpha.sql_db.parameter_group_name
  db_subnet_group_name                  = var.alpha.sql_db.db_subnet_group_name
  availability_zone                     = var.alpha.sql_db.availability_zone
  backup_retention_period               = var.alpha.sql_db.backup_retention_period
  maintenance_window                    = var.alpha.sql_db.maintenance_window
  monitoring_interval                   = var.alpha.sql_db.monitoring_interval
  monitoring_role_arn                   = local.monitoring_role_arn
  performance_insights_enabled          = var.alpha.sql_db.performance_insights_enabled
  performance_insights_retention_period = var.alpha.sql_db.performance_insights_retention_period
  deletion_protection                   = var.alpha.sql_db.deletion_protection
  license_model                         = "license-included"

  tags = var.alpha.tags
}
