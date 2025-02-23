variable "coredns_sg_id" {
    description = "The ID of the security group"
}

variable "vpc_id" {
    description = "The ID of the VPC"
}

variable "private_subnet_id" {
    description = "The ID of the private subnet"
}

variable "ssh_key" {
    description = "The name of the SSH key pair"
}

variable "services" {
  description = "Liste des services avec leurs IPs dynamiques"
  type        = map(string)
}
