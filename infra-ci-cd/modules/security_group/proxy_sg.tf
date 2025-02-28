resource "aws_security_group" "proxy_sg" {
  name        = "proxy_sg"
  description = "Security group for proxy"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3128
    to_port     = 3128
    protocol    = "tcp"
    cidr_blocks = ["10.0.2.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "proxy-sg"
  }
}