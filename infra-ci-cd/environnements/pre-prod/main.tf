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
  subnet_id = module.vpc.public_subnet_id
  ci_cd_sg_id = module.security_group.ci_cd_sg_id
}
