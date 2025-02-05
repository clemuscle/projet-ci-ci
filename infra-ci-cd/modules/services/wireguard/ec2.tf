resource "aws_instance" "wireguard" {
  ami           = "ami-0e6e2ea0ec444b23e"
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.wireguard_sg_id]
  subnet_id     = var.public_subnet_id

  key_name = var.ssh_key

  source_dest_check = false

  user_data = file("${path.module}/cloud-init.yaml")

  tags = {
    Name = "wireguard-instance"
  }
}

output "vpn_public_ip" {
  value = aws_instance.wireguard.public_ip
  description = "Adresse IP publique du serveur VPN"
}
