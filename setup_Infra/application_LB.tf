# Ref.: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
resource "aws_lb" "Alb" {
  depends_on         = [aws_lb_target_group.TG]
  name               = "Alb-project-1"
  internal           = false  // false meaning internet facing
  load_balancer_type = "application"
  security_groups    = [aws_security_group.project1_sg.id]
  subnets            = [aws_subnet.Public_subnet_az1.id, aws_subnet.Public_subnet_az2.id]

  tags = {
    Environment = "production"
  }
}

# Ref.: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
# Default Action Type : Forward
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.Alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG.arn
  }
}