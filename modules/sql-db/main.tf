resource "aws_db_instance" "this" {
  identifier                     = var.sql_db.db_identifier
  instance_class                 = var.sql_db.db_instance_class
  engine                         = var.sql_db.engine
  license_model                  = "license-included" 
  username                       = var.sql_db.username
  password                       = var.sql_db.password
  allocated_storage              = var.sql_db.allocated_storage
  iops                           = var.sql_db.iops
  multi_az                       = var.sql_db.multi_az
  publicly_accessible            = var.sql_db.publicly_accessible
  option_group_name              = var.sql_db.option_group_name
  parameter_group_name           = var.sql_db.parameter_group_name
  db_subnet_group_name           = var.sql_db.db_subnet_group_name
  availability_zone              = var.sql_db.availability_zone
  backup_retention_period        = var.sql_db.backup_retention_period
  maintenance_window             = var.sql_db.maintenance_window
  # monitoring_interval            = var.sql_db.monitoring_interval
  deletion_protection            = var.sql_db.deletion_protection
  performance_insights_enabled   = var.sql_db.performance_insights_enabled
  performance_insights_retention_period = var.sql_db.performance_insights_retention_period

  tags = {
    Name = var.sql_db.db_identifier
  }
}
