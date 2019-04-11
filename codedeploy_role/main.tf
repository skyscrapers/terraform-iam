
resource "aws_iam_role_policy_attachment" "codedeploy_policy" {
    role = "${aws_iam_role.codedeploy_role.id}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

resource "aws_iam_role" "codedeploy_role" {
    name_prefix = "codedeploy-role"
    assume_role_policy = "${data.aws_iam_policy_document.codedeploy_role.json}"
}



data "aws_iam_policy_document" "codedeploy_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codedeploy.${var.region}.amazonaws.com"]
    }
  }
}
