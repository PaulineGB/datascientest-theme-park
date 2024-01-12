module "EKS" {
  source               = "./eks"
  app                  = var.app
  vpc_id               = module.network.vpc_id
  public_nets          = module.network.public_nets
  instance_types       = var.instance_types
  ami_type             = var.ami_type
  account_id           = var.account_id
  namespace            = var.namespace
  iam_list             = var.iam_list
  cluster_issuer_email = var.cluster_issuer_email
}

module "network" {
  source          = "./network"
  vpc_cidr        = var.vpc_cidr
  app             = var.app
  aws_region      = var.aws_region
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}

module "rds" {
  source       = "./rds"
  aws_region   = var.aws_region
  app          = var.app
  vpc_id       = module.network.vpc_id
  db_name      = var.db_name
  db_username  = var.db_username
  db_password  = var.db_password
  private_nets = module.network.private_nets
  public_subnets  = var.public_subnets
}
