data "aws_iam_policy_document" "ro_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${var.admin_account_id}"]
    }
  }
}

resource "aws_iam_role" "ro" {
  name               = "readonly"
  description        = "This role has read only access to this account"
  assume_role_policy = "${data.aws_iam_policy_document.ro_assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "ro" {
  role       = "${aws_iam_role.ro.name}"
  policy_arn = "arn:aws:iam::aws:policy/ReadOnly"
}
