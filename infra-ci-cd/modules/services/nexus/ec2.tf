resource "aws_instance" "nexus_instance" {
  ami                    = "ami-0e6e2ea0ec444b23e" # AMI à utiliser
  instance_type          = "t2.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.nexus_sg_id]
  key_name               = var.ssh_key

  instance_market_options {
    market_type = "spot"
  }

  user_data = base64encode(templatefile("${path.module}/cloud-init.yaml", {
    config_content = file("../../configurations/nexus/nexus.properties")
  }))

  tags = {
    Name = "nexus-instance"
  }
}

output "nexus_instance_id" {
  value = aws_instance.nexus_instance.id
}

output "nexus_private_ip" {
  value = aws_instance.nexus_instance.private_ip
}