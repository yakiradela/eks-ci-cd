 module "aws_auth" {
  source  = "terraform-aws-modules/eks/aws//modules/aws-auth"
  version = "~> 20.0"

  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::557690607676:role/default-nodegroup-eks-node-group-20250530083922829700000001"
      username = "admin"
      groups   = ["system:masters"]
    }
  ]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::557690607676:user/yakir"
      username = "yakir"
      groups   = ["system:masters"]
    }
  ]

  depends_on = [module.eks]
}
