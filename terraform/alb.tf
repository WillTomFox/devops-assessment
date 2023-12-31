resource "aws_alb" "devops_assessment_alb" {
  name               = "devops-assessment-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [for subnet in aws_subnet.devops_assessment_subnet : subnet.id]
  security_groups    = [aws_security_group.devops_assessment_security_group.id]

#   tags = {
#     Name        = "${var.app_name}-alb"
#     Environment = var.app_environment
#   }
}

resource "aws_lb_target_group" "devops_assessment_target_group" {
  name        = "devops-assessment-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    unhealthy_threshold = "2"
  }

#   tags = {
#     Name        = "${var.app_name}-lb-tg"
#     Environment = var.app_environment
#   }
}

resource "aws_lb_listener" "devops_assessment_listener" {
  load_balancer_arn = aws_alb.devops_assessment_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.devops_assessment_target_group.id
  }
}