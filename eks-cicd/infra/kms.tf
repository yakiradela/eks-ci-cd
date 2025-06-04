 # ---------------------
# KMS KEY + ALIAS (conditional)
# ---------------------

resource "aws_kms_key" "eks" {
  count                    = var.create_kms_key ? 1 : 0
  description              = "KMS key for EKS encryption"
  deletion_window_in_days  = 10

  tags = {
    Name        = "EKS-KMSXYZ321"
    Environment = "dev"
  }
}

resource "aws_kms_alias" "eks_alias" {
  count         = var.create_kms_key ? 1 : 0
  name          = "alias/KMS/YAKIR321-cluster-kms-${var.cluster_name}"
  target_key_id = aws_kms_key.eks[0].id

  lifecycle {
    ignore_changes = [name]
  }
}

# Dynamic selection of KMS Key ARN
locals {
  eks_kms_key_arn = var.create_kms_key ? aws_kms_key.eks[0].arn : var.existing_kms_key_arn
}

# ---------------------
# DATA SOURCE: EKS Optimized AMI
# ---------------------

data "aws_ami" "eks_optimized" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-1.29-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners      = ["602401143452"] # AWS EKS AMI owner ID - AWS official
  most_recent = true
}

# ---------------------
# LAUNCH TEMPLATE
# ---------------------

resource "aws_launch_template" "eks_node_template" {
  name_prefix   = "eks-node-template-"
  image_id      = data.aws_ami.eks_optimized.id
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.instance_profile_name
  }

  user_data = base64encode(<<EOF
#!/bin/bash
/etc/eks/bootstrap.sh ${var.cluster_name}
/opt/aws/bin/cfn-signal --exit-code $? --stack $${AWS::StackName} --resource NodeGroup --region ${var.aws_region}
EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "eks-node"
    }
  }

  tags = {
    Name = "eks-node"
  }
}
