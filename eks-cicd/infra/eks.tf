module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.36.0"

  cluster_name    = "EKS-CLUSTER321"
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  create_kms_key = true

  cluster_encryption_config = {
    resources = ["secrets"]
  }

  eks_managed_node_groups = {
    default = {
      name             = "default-nodegroup"
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
      key_name         = var.key_pair_name

      launch_template = {
        id      = aws_launch_template.eks_node_template.id
        version = "$Latest"
      }

      iam_role_additional_policies = {
        AmazonEKSWorkerNodePolicy           = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
        AmazonEKS_CNI_Policy               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
