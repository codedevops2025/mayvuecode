locals {
  config = yamldecode(file("${path.module}/../../environments/brm.yaml"))
}

module "sql" {
  source = "../../modules/sql-db"
  sql_db = local.config.sql_db
}