module "vpc" {
  source = "./modules/VPC"
}

module "eks" {
  source                    = "./modules/EKS"
  subnet_id_1               = module.vpc.subnet-1-id
  subnet_id_2               = module.vpc.subnet-2-id
  source_security_group_ids = module.vpc.sg-id
}