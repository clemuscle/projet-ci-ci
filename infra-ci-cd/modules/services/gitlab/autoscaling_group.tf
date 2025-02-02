resource "aws_launch_template" "gitlab_launch_template" {
  name_prefix   = "gitlab-launch-template"
  image_id      = "ami-0e6e2ea0ec444b23e" # AMI à utiliser
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.gitlab_sg_id]

  key_name = var.ssh_key

  user_data = base64encode(templatefile("${path.module}/cloud-init.yaml", {
    config_content = file("../../configurations/gitlab/gitlab.rb")
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "gitlab-instance"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "gitlab_asg" {
  name = "gitlab_asg"
  launch_template {
    id      = aws_launch_template.gitlab_launch_template.id
    version = "$Latest"
  }

  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  vpc_zone_identifier = [var.private_subnet_id]

  tag {
    key                 = "Name"
    value               = "GitLab"
    propagate_at_launch = true
  }
}

# A voir pour le update_policy pour permettre de mettre à jour le service avec le autoscaling group qui s'occope de rm et créer une nouvelle instance avec la nouvelle configuration


output "gitlab_asg_id" {
  value = aws_autoscaling_group.gitlab_asg.id
}

output "gitlab_asg_arn" {
  value = aws_autoscaling_group.gitlab_asg.arn
}