 resource "aws_iam_role" "eks_nodes" {
  name = "eks-node-role-${random_string.suffix.result}"
  assume_role_policy = data.aws_iam_policy_document.eks_nodes_assume_role.json
}

resource "random_string" "suffix" {
  length  = 6
  special = false
}

data "aws_iam_policy_document" "eks_nodes_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
