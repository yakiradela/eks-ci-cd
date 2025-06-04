 data "aws_iam_policy_document" "eks_minimal_policy" {
  # הרשאות לניהול משאבי EC2
  statement {
    sid    = "EC2Permissions"
    effect = "Allow"
    actions = [
      "ec2:CreateVpc",
      "ec2:DeleteVpc",
      "ec2:CreateSubnet",
      "ec2:DeleteSubnet",
      "ec2:CreateInternetGateway",
      "ec2:AttachInternetGateway",
      "ec2:DeleteInternetGateway",
      "ec2:CreateNatGateway",
      "ec2:DeleteNatGateway",
      "ec2:AllocateAddress",
      "ec2:ReleaseAddress",
      "ec2:AssociateAddress",
      "ec2:CreateRouteTable",
      "ec2:AssociateRouteTable",
      "ec2:CreateRoute",
      "ec2:DeleteRouteTable",
      "ec2:ModifyVpcAttribute",
      "ec2:CreateSecurityGroup",
      "ec2:CreateLaunchTemplate",
      "ec2:CreateTags"
    ]
    resources = ["*"]
  }

  # הרשאות קריאה למשאבי EC2
  statement {
    sid    = "EC2ReadPermissions"
    effect = "Allow"
    actions = [
      "ec2:DescribeImages",
      "ec2:DescribeInstances",
      "ec2:DescribeVpcs",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeLaunchTemplates"
    ]
    resources = ["*"]
  }

  # הרשאות ניהול IAM להקמת EKS
  statement {
    sid    = "IAMPermissions"
    effect = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:PutRolePolicy",
      "iam:AttachRolePolicy",
      "iam:CreatePolicy",
      "iam:PassRole"
    ]
    resources = ["*"]
  }

  # הרשאות קריאה ב-IAM
  statement {
    sid    = "IAMReadPermissions"
    effect = "Allow"
    actions = [
      "iam:GetRole",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListRoles",
      "iam:ListPolicies",
      "iam:ListAttachedRolePolicies",
      "iam:ListRolePolicies"
    ]
    resources = ["*"]
  }

  # הרשאות ל-EKS
  statement {
    sid    = "EKSPermissions"
    effect = "Allow"
    actions = [
      "eks:*"
    ]
    resources = ["*"]
  }

  # הרשאות S3
  statement {
    sid    = "S3Permissions"
    effect = "Allow"
    actions = [
      "s3:CreateBucket",
      "s3:PutBucketVersioning",
      "s3:PutBucketPolicy",
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = ["*"]
  }

  # הרשאות CloudWatch Logs
  statement {
    sid    = "CloudWatchLogsPermissions"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:PutRetentionPolicy",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = ["*"]
  }

  # הרשאות KMS
  statement {
    sid    = "KMSPermissions"
    effect = "Allow"
    actions = [
      "kms:CreateKey",
      "kms:TagResource",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "eks_minimal_policy" {
  name        = "eksMinimalPolicy"
  description = "Minimal policy for EKS cluster creation with Terraform"
  policy      = data.aws_iam_policy_document.eks_minimal_policy.json
}
