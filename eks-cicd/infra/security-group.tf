 resource "aws_security_group" "eks_nodes" {
  name        = "eks-nodes-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port                = 443
    to_port                  = 443
    protocol                 = "tcp"
    security_groups          = [module.eks.cluster_security_group_id]
    description              = "EKS Control Plane to worker nodes"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "Allow node-to-node communication"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-nodes"
  }
}
