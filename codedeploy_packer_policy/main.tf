resource "aws_iam_policy" "codedeploy_install_policy" {
  name        = "codedeploy-install-policy"
  description = "A policy to allow download of codedeploy install script"

  policy = <<EOF
{
"Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::aws-codedeploy-${var.region}/*"
    }
  ]
}
EOF

}

