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

output "vpn_public_ip" {
  value = module.wireguard.vpn_public_ip
  description = "Adresse IP publique du serveur VPN"
}
