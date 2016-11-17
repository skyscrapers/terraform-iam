resource "aws_iam_policy" "kms_policy" {
  name        = "kms-usage-policy-${var.name}"
  description = "A policy to allow usage (encrypt & decrypt) of a KMS key"

  policy = <<EOF
{
"Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Describe*",
        "kms:Get*",
        "kms:List*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt"
      ],
      "Effect": "Allow",
      "Resource": "${var.kms_key_arn}"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "kms_policy_attach" {
  role       = "${var.aws_iam_role_name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}
