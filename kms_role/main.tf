resource "aws_iam_instance_profile" "packer_profile" {
  name  = "profile_packer_${var.environment}"
  roles = ["${aws_iam_role.packer_role.name}"]
}

resource "aws_iam_role" "packer_role" {
  name = "role_packer_${var.environment}"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "packer_policy" {
  name = "policy_packer_${var.environment}"
  role = "${aws_iam_role.packer_role.id}"

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
