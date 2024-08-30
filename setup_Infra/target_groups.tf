# Ref.:  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
resource "aws_lb_target_group" "TG" {
  name     = "project1-TG-Alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

  health_check {
    enabled = true
    # The number of consecutive health checks successes required before considering an unhealthy target healthy.
    healthy_threshold = 5
    # The number of consecutive health check failures required before considering a target unhealthy.
    unhealthy_threshold = 2
    # The approximate amount of time between health checks of an individual target
    interval = 10
    # The HTTP codes to use when checking for a successful response from a target.
    matcher = "200"
    # Health check path
    path = "/"
  }

  #   lifecycle {
  #     create_before_destroy = true # Ensures the new TG is created before the old one is destroyed
  #   }
}

# Ref.: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment
# Target type : instances
resource "aws_lb_target_group_attachment" "TG_attachment" {
  for_each = {
    "instance1" = aws_instance.pub_instance1.id
    "instance2" = aws_instance.pub_instance2.id
  }

  target_group_arn = aws_lb_target_group.TG.arn
  target_id        = each.value
  port             = 80
}