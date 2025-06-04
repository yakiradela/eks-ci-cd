variable "cluster_name" {
  type = string
}

variable "key_pair_name" {
  type = string
}

variable "instance_profile_name" {
  type = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "create_kms_key" {
  description = "Whether to create a new KMS key or use an existing one"
  type        = bool
  default     = true
}

variable "existing_kms_key_arn" {
  description = "ARN of an existing KMS key to use (if create_kms_key = false)"
  type        = string
  default     = ""
}
