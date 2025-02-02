variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "private_subnet_id" {
  description = "The ID of the private subnet"
}

variable "gitlab_sg_id" {
  description = "The ID of the GitLab security group"
}

variable "ssh_key" {
  description = "The name of the SSH key pair"
}