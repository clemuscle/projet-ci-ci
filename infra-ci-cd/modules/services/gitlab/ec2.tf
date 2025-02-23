resource "aws_instance" "gitlab_instance" {
  ami                    = "ami-0e6e2ea0ec444b23e" # AMI à utiliser
  instance_type          = "t2.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.gitlab_sg_id]
  key_name               = var.ssh_key

  instance_market_options {
    market_type = "spot"
  }

  user_data = base64encode(templatefile("${path.module}/cloud-init.yaml", {
    config_content = file("../../configurations/gitlab/gitlab.rb")
  }))

  tags = {
    Name = "gitlab-instance"
  }
}

output "gitlab_instance_id" {
  value = aws_instance.gitlab_instance.id
}

output "gitlab_private_ip" {
  value = aws_instance.gitlab_instance.private_ip
}
