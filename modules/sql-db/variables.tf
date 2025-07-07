variable "alpha" {
  description = "SQL DB configuration"
  type = object({
    sql_db = object({
      db_identifier                         = string
      db_instance_class                     = string
      engine                                = string
      username                              = string
      password                              = string
      allocated_storage                     = number
      iops                                  = number
      multi_az                              = bool
      db_name                                = string
      publicly_accessible                   = bool
      option_group_name                     = string
      parameter_group_name                  = string
      db_subnet_group_name                  = string
      availability_zone                     = string
      backup_retention_period               = number
      maintenance_window                    = string
      monitoring_interval                   = number
      performance_insights_enabled          = bool
      performance_insights_retention_period = number
      deletion_protection                   = bool
      create_monitoring_role                = bool
      create_option_group                   = bool
    })

    option_group = object({
      name                  = string
      engine_name           = string
      major_engine_version  = string
      options               = list(object({
        option_name                    = string
        port                           = optional(number)
        vpc_security_group_memberships = optional(list(string))
      }))
      tags                  = map(string)
    })

    tags = object({
      env     = string
      project = string
      owner   = string
    })
  })
}
