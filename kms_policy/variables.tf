variable "name" {
  description = "Name to differentiate the policy name"
}

variable "kms_key_arn" {
  description = "ARN of the KMS key to use"
}

variable "aws_iam_role_name" {
  default = "IAM role name to attach to the policy"
}
