resource "aws_lb" "app-lb" {
  name               = "${var.awsenv}-app-lb" 
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_groups]
  subnets            = var.subnets
  enable_deletion_protection = true
  
  tags = {
    Environment = var.awsenv
  }
}

resource "aws_lb_target_group" "app-targets" {
  name     = "app-servers-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "app-tg-attachments" {
  count 		= length(var.target_servers)
  target_group_arn 	= aws_lb_target_group.app-targets.arn
  target_id        	= var.target_servers[count.index]
  port             	= 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-targets.arn
  }
}

