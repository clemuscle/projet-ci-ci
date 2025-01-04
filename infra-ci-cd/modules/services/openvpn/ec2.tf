resource "aws_instance" "openvpn" {
  ami           = "ami-0e6e2ea0ec444b23e"
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.openvpn_sg_id]
  subnet_id     = var.public_subnet_id

  user_data = file("${path.module}/cloud-init.yaml")

  tags = {
    Name = "openvpn-server"
  }
}

output "vpn_public_ip" {
  value = aws_instance.openvpn.public_ip
  description = "Adresse IP publique du serveur VPN"
}
