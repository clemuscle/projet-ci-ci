resource "aws_instance" "nginx_proxy" {
  ami           = "ami-0e6e2ea0ec444b23e"
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.nginx_sg_id]
  subnet_id     = var.private_subnet_id

  user_data = templatefile("${path.module}/nginx/cloud-init-nginx.yaml", {
    gitlab_ip = aws_instance.gitlab.private_ip,
    nexus_ip  = aws_instance.nexus.private_ip
  })
}