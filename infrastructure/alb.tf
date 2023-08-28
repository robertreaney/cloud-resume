resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Allow inbound traffic for ALB"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  enable_deletion_protection = false

  enable_cross_zone_load_balancing = true
  subnets                          = ["subnet-abc12345", "subnet-xyz67890"] # Replace with your VPC's subnet IDs

  enable_http2 = true
}

resource "aws_lb_target_group" "my_tg" {
  name     = "my-tg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = "vpc-abc12345" # Replace with your VPC ID

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"  # Adjust to a specific health check endpoint if needed
    port                = "5000"
    protocol            = "HTTP"
    timeout             = 3
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "my_tg_attachment" {
  target_group_arn = aws_lb_target_group.my_tg.arn
  target_id        = "i-abc12345abc12345"  # Replace with your EC2 instance ID
  port             = 5000
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08" # Or a more recent policy
  certificate_arn   = "arn:aws:acm:us-west-2:123456789012:certificate/abc12345-abc1-abc1-abc1-abc12345abc1" # Replace with your ACM certificate ARN

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
}

