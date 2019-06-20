locals {
  environment = var.environment == "" ? terraform.workspace : var.environment
}

# This user will be used to automate Terraform stacks in CI, so it needs admin access to AWS
resource "aws_iam_user" "terraform_ci" {
  name = "terraform-ci-${local.environment}"
  path = "/ci/"

  tags = {
    Environment = local.environment
    Role        = "terraform-ci"
  }
}

resource "aws_iam_access_key" "terraform_ci" {
  user    = aws_iam_user.terraform_ci.name
  pgp_key = var.pgp_key
}

resource "aws_iam_user_policy_attachment" "terraform_ci_admin_policy" {
  user       = aws_iam_user.terraform_ci.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

