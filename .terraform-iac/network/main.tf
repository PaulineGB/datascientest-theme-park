# recupère dynamiquement les zones de disponibilités
data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"

  name = "${var.app}-VPC"

  cidr                    = var.vpc_cidr
  azs                     = data.aws_availability_zones.available.names
  private_subnets         = var.private_subnets
  public_subnets          = var.public_subnets
  create_igw              = true
  enable_nat_gateway      = false
  map_public_ip_on_launch = true

  tags = {
    app       = "${var.app}"
    tf_module = "${var.app}-vpc"
  }
}
