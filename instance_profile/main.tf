resource "aws_iam_instance_profile" "profile" {
  name  = "profile_${var.project}_${var.environment}_${var.function}"
  role = aws_iam_role.role.name
}

resource "aws_iam_role_policy" "policy" {
  name   = "policy_${var.project}_${var.environment}_${var.function}"
  role   = aws_iam_role.role.id
  policy = var.aws_iam_role_policy
}

resource "aws_iam_role" "role" {
  name               = "policy_${var.project}_${var.environment}_${var.function}"
  assume_role_policy = var.aws_iam_role
}

