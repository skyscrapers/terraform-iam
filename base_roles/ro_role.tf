data "aws_iam_policy_document" "ro_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.readonly_role_principal_ids
    }
  }
}

resource "aws_iam_role" "ro" {
  name               = "readonly"
  path               = "/ops/"
  description        = "This role has read only access to this account"
  assume_role_policy = data.aws_iam_policy_document.ro_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ro" {
  role       = aws_iam_role.ro.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

