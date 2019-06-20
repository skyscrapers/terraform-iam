variable "project" {
  description = "The current project"
}

variable "environment" {
  description = "How do you want to call your environment, this is helpful if you have more than 1 VPC."
}

variable "function" {
  default = ""
}

variable "aws_iam_role" {
  default = <<EOF
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

variable "aws_iam_role_policy" {
  default = ""
}

