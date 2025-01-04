module "vpc" {
  source = "../../modules/vpc"
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
}

module "nexus" {
  source = "../../modules/services/nexus"
  vpc_id = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_id
  nexus_sg_id = module.security_group.nexus_sg_id
}

module "openvpn" {
  source = "../../modules/services/openvpn"
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  openvpn_sg_id = module.security_group.openvpn_sg_id
}

output "vpn_public_ip" {
  value = module.openvpn.vpn_public_ip
  description = "Adresse IP publique du serveur VPN"
}
