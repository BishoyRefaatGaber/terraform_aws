resource "aws_lb" "nlb" {
  internal                         = var.private-nlb
  load_balancer_type               = "network"
  subnets                          = var.subnet-id
  security_groups                  = var.nlb-sg
  enable_cross_zone_load_balancing = true
  tags = {
    Name = var.nlb-tag
  }
}
