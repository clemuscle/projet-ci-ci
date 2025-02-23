resource "aws_instance" "coredns" {
  ami           = "ami-0e6e2ea0ec444b23e"
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet_id
  vpc_security_group_ids = [var.coredns_sg_id]
  key_name = var.ssh_key

  instance_market_options {
    market_type = "spot"
  }

  user_data = base64encode(templatefile("${path.module}/cloud-init.yaml", {
    services = var.services
  }))

  tags = {
    Name = "coredns-instance"
  }
}



output "coredns_private_ip" {
  value = aws_instance.coredns.private_ip
  description = "Adresse IP privée du serveur coredns"
}
