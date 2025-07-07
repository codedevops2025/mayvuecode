variable "config" {
  type = object({
    ec2 = object({
      aws_region           = string
      ami_id               = string
      instance_type        = string
      key_name             = string
      subnet_name          = string
      security_group_names = list(string)
      # instance_name        = string
      volume_size          = string
    })
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