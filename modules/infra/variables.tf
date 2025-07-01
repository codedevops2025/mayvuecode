variable "infra" {
  type = object({
    vpc = object({
      cidr = string
      id   = string
    })
    tags = object({
      env = string
      project = string
      owner = string
    })
  })
}
variable "public_nat_2a_id" {
  type = string
}