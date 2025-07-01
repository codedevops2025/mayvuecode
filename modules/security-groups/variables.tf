variable "alpha" {
  description = "Parsed YAML config"
  type = object({
    vpc = object({
      cidr = string
      id   = string
    })
    subnets = list(string)
    routes = object({
      infra_cidr_block   = string
    })
    tags = object({
      env = string
      project = string
      owner = string
    })
  })
}