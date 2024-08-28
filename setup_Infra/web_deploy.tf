resource "null_resource" "deploy_web1" {
  depends_on = [aws_instance.pub_instance1]
  connection {
    type        = "ssh"
    host        = aws_instance.pub_instance1.public_ip
    user        = "ubuntu"
    private_key = file("${path.module}/keys/id_rsa")
  }
  provisioner "remote-exec" {
    script = "web1_deploy.sh"
  }
}

resource "null_resource" "deploy_web2" {
  depends_on = [aws_instance.pub_instance2]
  connection {
    type        = "ssh"
    host        = aws_instance.pub_instance2.public_ip
    user        = "ubuntu"
    private_key = file("${path.module}/keys/id_rsa")
  }
  provisioner "remote-exec" {
    script = "web2_deploy.sh"
  }
}