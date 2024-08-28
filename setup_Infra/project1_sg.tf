# Ref.: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

resource "aws_security_group" "project1_sg" {
  name        = "project1_sg"
  description = "Allow ssh & web traffic"
  vpc_id = aws_vpc.my_vpc.id // must be in same vpc

  tags = {
    Name = "SG_vishal"
  }

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Allow all outbound rules
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}