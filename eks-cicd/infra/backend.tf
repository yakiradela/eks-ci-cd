terraform {
  backend "s3" {
    bucket         = "eks-terraform-statexyz123"
    key            = "eks/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table" # אופציונלי – ניצור בהמשך אם תרצה
  }
}
