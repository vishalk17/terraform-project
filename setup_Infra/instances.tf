# Fetch ami id of latest ubuntu image using datasource
# Ref. : https://developer.hashicorp.com/terraform/language/data-sources
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "owner-id"
    values = ["099720109477"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

output "ami" {
  value = data.aws_ami.ubuntu
}

# Create instance in az1
# Ref.: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "pub_instance1" {
  depends_on             = [aws_key_pair.project1_key_pair]
  ami                    = data.aws_ami.ubuntu.id // Fetching ami id using datasource
  instance_type          = var.environment == "production-high-capacity" ? var.high_capacity : "t2.small"
  key_name               = aws_key_pair.project1_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.project1_sg.id]
  subnet_id              = aws_subnet.Public_subnet_az1.id
  tags = {
    Name = "instance-az1"
  }
}

# Create instance in az2
resource "aws_instance" "pub_instance2" {
  depends_on                  = [aws_key_pair.project1_key_pair]
  ami                         = data.aws_ami.ubuntu.id // Fetching ami id using datasource
  instance_type               = var.environment == "production-high-capacity" ? var.high_capacity : "t2.small"
  key_name                    = aws_key_pair.project1_key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.project1_sg.id]
  subnet_id                   = aws_subnet.Public_subnet_az2.id
  associate_public_ip_address = true
  tags = {
    Name = "instance-az2"
  }
}