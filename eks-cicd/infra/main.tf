 resource "aws_s3_bucket" "tf_state" {
  bucket = "eks-terraform-statexyz123"
  force_destroy = true

  tags = {
    Name        = "eks-terraform-state"
    Environment = "dev"
  }
}
