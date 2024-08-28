resource "aws_key_pair" "project1_key_pair" {
  key_name   = "project1_key_pair"
  public_key = file("${path.module}/keys/id_rsa.pub")
}