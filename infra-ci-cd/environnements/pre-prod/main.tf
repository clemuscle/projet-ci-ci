data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket         = "infra-ci-cd-terraform-states"
    key            = "environments/pre-prod/terraform.tfstate"
    region         = var.region
    dynamodb_table = "terraform-lock"
    encrypt        = true
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
  }
}

module "vpc" {
  source = "../../modules/vpc"
}

module "ssh" {
  source = "../../modules/ssh"
}

module "security_group" {
  source = "../../modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "gitlab" {
  source = "../../modules/services/gitlab"
  vpc_id = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_id
  gitlab_sg_id = module.security_group.gitlab_sg_id
  ssh_key = module.ssh.ssh_key
}

module "nexus" {
  source = "../../modules/services/nexus"
  vpc_id = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_id
  nexus_sg_id = module.security_group.nexus_sg_id
  ssh_key = module.ssh.ssh_key
}

module "wireguard" {
  source = "../../modules/services/wireguard"
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  wireguard_sg_id = module.security_group.wireguard_sg_id
  ssh_key = module.ssh.ssh_key
}


output "wireguard_public_ip" {
  value = module.wireguard.wireguard_public_ip
  description = "Adresse IP publique du serveur VPN"
}

module "coredns" {
  source = "../../modules/services/coredns"
  vpc_id = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_id
  coredns_sg_id = module.security_group.coredns_sg_id
  ssh_key = module.ssh.ssh_key
  services = {
    "gitlab" = module.gitlab.gitlab_private_ip
    "nexus" = module.nexus.nexus_private_ip
    "wireguard" = module.wireguard.wireguard_private_ip
  }
}

module "proxy" {
  source = "../../modules/services/proxy"
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  proxy_sg_id = module.security_group.proxy_sg_id
  ssh_key = module.ssh.ssh_key
}

output "proxy_public_ip" {
  value = module.proxy.proxy_public_ip
  description = "Adresse IP publique du serveur proxy"
}
