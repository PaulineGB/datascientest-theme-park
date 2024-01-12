data "aws_eks_cluster_auth" "default" {
  name = "tpr"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.default.token
}

locals {  
  list_aws_auth_user = [
    for iam_user in var.iam_list:
    {
      userarn  = "arn:aws:iam::${var.account_id}:user/${iam_user}"
      username = "${iam_user}"
      groups   = ["system:masters"]
    }
  ]
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.app
  cluster_version = "1.28"

  cluster_endpoint_public_access = true

  vpc_id                   = var.vpc_id
  subnet_ids               = var.public_nets
  control_plane_subnet_ids = var.public_nets

  create_kms_key = false
  attach_cluster_encryption_policy = false
  cluster_encryption_config = {}
  eks_managed_node_group_defaults = {
    ami_type       = "${var.ami_type}"
    instance_types = ["${var.instance_types}"]
  }

  eks_managed_node_groups = {
    node-group1 = {
      name = "${var.app}-node-group"

      min_size     = 2
      max_size     = 2
      desired_size = 2

    }
  }

  cluster_addons = {
    amazon-cloudwatch-observability = {
      most_recent = true
    }
  }
  # aws-auth configmap
  manage_aws_auth_configmap = true
  aws_auth_users = local.list_aws_auth_user

  tags = {
    app       = "${var.app}"
    tf_module = "${var.app}-eks"
  }
}

resource "aws_iam_role_policy_attachment" "attach_cloudwatch_agent_server_policy" {
  role = module.eks.eks_managed_node_groups["node-group1"].iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "attach_aws_xray_write_only_access_policy" {
  role = module.eks.eks_managed_node_groups["node-group1"].iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.default.token
  }
}

resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert-manager" {
  name      = "cert-manager"
  namespace = "cert-manager"

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "kubernetes_namespace" "traefik" {
  metadata {
    name = "traefik"
  }
}

resource "helm_release" "traefik_ingress" {
  name      = "traefik"
  namespace = "traefik"

  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"

  values = [
    "${file("./eks/traefik_values.yaml")}"
  ]
}

provider "kubectl" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.default.token
}

data "template_file" "cluster-issuer" {
  template = file("./eks/cluster-issuer.yaml")
  vars = {
    cluster_issuer_email = var.cluster_issuer_email
  }
}

resource "kubectl_manifest" "cluster-issuer" {
  yaml_body = tostring(data.template_file.cluster-issuer.rendered)

  depends_on = [helm_release.cert-manager]
}

resource "kubernetes_namespace" "list_namespace" {
  for_each = toset(var.namespace)
  metadata {
    name = each.key
  }
}

