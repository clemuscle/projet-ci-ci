resource "aws_launch_template" "nexus_launch_template" {
  name_prefix   = "nexus-launch-template"
  image_id      = "ami-0e6e2ea0ec444b23e" # AMI à utiliser
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.nexus_sg_id]

  key_name = var.ssh_key

  user_data = base64encode(templatefile("${path.module}/cloud-init.yaml", {
    config_content = file("../../configurations/nexus/nexus.properties")
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "nexus-instance"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "nexus_asg" {
  name = "nexus_asg"
  launch_template {
    id      = aws_launch_template.nexus_launch_template.id
    version = "$Latest"
  }

  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  vpc_zone_identifier = [var.private_subnet_id]

  tag {
    key                 = "Name"
    value               = "Nexus"
    propagate_at_launch = true
  }
}

# A voir pour le update_policy pour permettre de mettre à jour le service avec le autoscaling group qui s'occope de rm et créer une nouvelle instance avec la nouvelle configuration


output "nexus_asg_id" {
  value = aws_autoscaling_group.nexus_asg.id
}

output "nexus_asg_arn" {
  value = aws_autoscaling_group.nexus_asg.arn
}