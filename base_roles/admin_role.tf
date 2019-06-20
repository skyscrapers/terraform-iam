data "aws_iam_policy_document" "admin_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.admin_role_principal_ids
    }
  }
}

resource "aws_iam_role" "admin" {
  name               = "admin"
  path               = "/ops/"
  description        = "This role has full Aministrator access and is to be assumed to mange this account"
  assume_role_policy = data.aws_iam_policy_document.admin_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "admin" {
  role       = aws_iam_role.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

