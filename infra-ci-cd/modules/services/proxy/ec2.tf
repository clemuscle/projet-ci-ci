resource "aws_instance" "proxy" {
  ami           = "ami-0e6e2ea0ec444b23e"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_id
  vpc_security_group_ids = [var.proxy_sg_id]
  key_name = var.ssh_key

  instance_market_options {
    market_type = "spot"
  }

  user_data = base64encode(templatefile("${path.module}/cloud-init.yaml", {

  }))

  tags = {
    Name = "proxy-instance"
  }
}

output "proxy_public_ip" {
  value = aws_instance.proxy.public_ip
  description = "Adresse IP publique du serveur proxy"
}
