module "nlb-public" {
  source      = "./modules/nlb"
  private-nlb = false
  subnet-id   = [module.subnet-public-us-east-1a.subnet-id, module.subnet-public-us-east-1b.subnet-id]
  nlb-tag     = "public-nlb"
  nlb-sg      = [module.sgroup.sg-id]
}





resource "aws_lb_target_group" "nlb-tg-public" {
  port        = 80
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = module.vpc-main.vpc-id
}



resource "aws_lb_listener" "nlb-listeners-public" {
  load_balancer_arn = module.nlb-public.nlb-arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb-tg-public.arn
  }
}

resource "aws_lb_target_group_attachment" "nlb2-ec2-1a-public" {
  target_group_arn = aws_lb_target_group.nlb-tg-public.arn
  #   var.tg-arn
  target_id = module.ec2-public-us-east-1a.ec2-id
  #   var.ec2-id
  port = 80
}

resource "aws_lb_target_group_attachment" "nlb2-ec2-1b-public" {
  target_group_arn = aws_lb_target_group.nlb-tg-public.arn
  #   var.tg-arn
  target_id = module.ec2-public-us-east-1b.ec2-id
  #   var.ec2-id
  port = 80
}












module "nlb-private" {
  source      = "./modules/nlb"
  private-nlb = true
  subnet-id   = [module.subnet-private-us-east-1a.subnet-id, module.subnet-private-us-east-1b.subnet-id]
  nlb-tag     = "private-nlb"
  nlb-sg      = [module.sgroup.sg-id]
}

resource "aws_lb_target_group" "nlb-tg-private" {
  port        = 80
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = module.vpc-main.vpc-id
}

resource "aws_lb_listener" "nlb-listeners-private" {
  load_balancer_arn = module.nlb-private.nlb-arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb-tg-private.arn
  }
}

resource "aws_lb_target_group_attachment" "nlb2-ec2-1a-private" {
  target_group_arn = aws_lb_target_group.nlb-tg-private.arn
  #   var.tg-arn
  target_id = module.ec2-private-us-east-1a.ec2-id
  #   var.ec2-id
  port = 80
}

resource "aws_lb_target_group_attachment" "nlb2-ec2-1b-private" {
  target_group_arn = aws_lb_target_group.nlb-tg-private.arn
  #   var.tg-arn
  target_id = module.ec2-private-us-east-1b.ec2-id
  #   var.ec2-id
  port = 80
}