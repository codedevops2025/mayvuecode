data "aws_security_group" "selected" {
  for_each = toset(var.config.ec2.security_group_names)

  filter {
    name   = "tag:Name"
    values = [each.key]
  }

  filter {
    name   = "vpc-id"
    values = [var.config.vpc.id] 
  }
}

data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.config.ec2.subnet_name]
  }

  filter {
    name   = "vpc-id"
    values = [var.config.vpc.id]
  }
}

resource "aws_instance" "brm_alpha" {
  ami                         = var.config.ec2.ami_id
  instance_type               = var.config.ec2.instance_type
  key_name                    = var.config.ec2.key_name
  subnet_id                   = data.aws_subnet.selected.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [for sg in data.aws_security_group.selected : sg.id]


  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.config.ec2.volume_size
    delete_on_termination = true
  }

  ebs_optimized = false

  metadata_options {
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    http_endpoint               = "enabled"
    instance_metadata_tags      = "disabled"
    http_protocol_ipv6          = "disabled"
  }

  monitoring = false

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  enclave_options {
    enabled = false
  }

  hibernation = false

  maintenance_options {
    auto_recovery = "default"
  }

  tags = merge(var.config.tags, {
    Name = "${var.config.tags.env}-${var.config.tags.project}-instance"
  })
}




# resource "aws_lb_target_group" "https_target_group" {
#   name = "${var.config.tags.env}-${var.config.tags.project}-tg"
#   port     = 443
#   protocol = "HTTPS"
#   vpc_id   = var.config.vpc.id

#   target_type = "instance"

#   health_check {
#     protocol = "HTTPS"
#     port     = "443"
#     path     = "/"
#     matcher  = "200"
#     interval = 30
#     timeout  = 5
#     healthy_threshold   = 3
#     unhealthy_threshold = 2
#   }

#   tags = merge(var.config.tags, {
#     Name = "${var.config.tags.env}-${var.config.tags.project}-tg"
#   })
# }

# resource "aws_lb_target_group_attachment" "https_instance_attachment" {
#   target_group_arn = aws_lb_target_group.https_target_group.arn
#   target_id        = aws_instance.brm_alpha.id
#   port             = 443
# }

