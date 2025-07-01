variable "config" {
  description = "Parsed configuration from brm.yaml"
  type = object({
    vpc = object({
      cidr = string
      id   = string
    })
    subnets = list(string)
    routes = object({
      infra_cidr_block   = string
      # transit_gateway_id = string
    })
    tags = object({
      env = string
      project = string
      owner = string
    })
  })
}