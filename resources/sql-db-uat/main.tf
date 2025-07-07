locals {
  config = yamldecode(file("${path.module}/../../environments/brm.yaml"))
}

module "sql" {
  source = "../../modules/sql-db"

  alpha = {
    sql_db = local.config.sql_db
    tags   = local.config.tags

    option_group = local.config.sql_db.option_group # <-- Add this line if it's nested under sql_db
  }
}
