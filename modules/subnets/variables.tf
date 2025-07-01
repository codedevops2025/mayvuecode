variable "alpha" {
  description = "YAML config with VPC and subnet info"
  type = object({
    vpc = object({
      cidr = string
      id   = string
    })
    subnets = list(string)
    tags = object({
      env = string
      project = string
      owner = string
    })
  })
}