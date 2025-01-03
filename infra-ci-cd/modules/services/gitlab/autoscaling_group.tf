resource "aws_launch_configuration" "gitlab_launch_config" {
  name          = "gitlab-launch-configuration"
  image_id     = "ami-12345678" # Remplacez par l'AMI de votre choix
  instance_type = "t2.medium"     # Choisissez le type d'instance
  security_groups = [var.ci_cd_sg_id] # Remplacez par l'ID de votre groupe de sécurité

  user_data = templatefile("${path.module}/cloud-init.yaml", {
    config_content = file("../../configurations/gitlab/conf.yaml")
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "gitlab_asg" {
  launch_configuration = aws_launch_configuration.gitlab_launch_config.id
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  vpc_zone_identifier = [var.subnet_id] # Remplacez par votre ID de sous-réseau

  tag {
    key                 = "Name"
    value               = "GitLabInstance"
    propagate_at_launch = true
  }
}